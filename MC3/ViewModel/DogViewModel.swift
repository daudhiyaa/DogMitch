//
//  DogViewModel.swift
//  MC3
//
//  Created by Marsha Likorawung on 17/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import SwiftUI

enum ImageType {
    case profilePicture
    case picture1
    case picture2
    case stamboom
    case medicalRecord
    case vaccine
}

class DogViewModel: ObservableObject{
    @Published var dog = [Dog]()
    @Published var dogs = Dog.emptyDog
    @Published var uploadStatus: String?
    @Published var uploadCheckerInfo: [String] = []
    @Published var uploadCheckerMedical: [String] = []
    @Published var uploadCountInfo: Int = 0
    @Published var uploadCountMedical: Int = 0
    @Published var image = ""
    @Published var fetchedDogs = [Dog]()
    @Published var myDog = Dog.emptyDog
    @AppStorage("registeredDogID") private var registeredDogID: String = "invalid_id"

    let db = Firestore.firestore()
    
    init(){
        dog = Dog.sampleDogList
    }
    
    func addDog(newDog: Dog) async{
        do {
            let ref = try await db.collection("dog").addDocument(data: newDog.dictionary)
            print("Document added with ID: \(ref.documentID)")
            registeredDogID = ref.documentID
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    func fetchDogByID() async {
      let docRef = db.collection("dog").document(registeredDogID)

      do {
        let document = try await docRef.getDocument()
        if document.exists {
          guard let data = document.data() else {
            print("Error: Document data is unexpectedly nil")
            return
          }

          // Map data to Dog object
          let dog = mapDataToDog(data: data)
          
          // Update UI or perform other actions with the Dog object
          DispatchQueue.main.async {
              self.myDog = dog
          }
        } else {
            print("Document does not exist")
        }
      } catch {
        print("Error getting documents: \(error)")
      }
    }

    // Helper function to map data dictionary to Dog object
    private func mapDataToDog(data: [String: Any]) -> Dog {
        
        var newPersonality: [Personality] = []
        for personality in data["personality"] as? [String] ?? [] {
            newPersonality.append(Personality(value: personality))
        }
        
        let birthDate: Date = convertToDate(dateString: data["birthday"] as? String ?? "") ?? Date()
        let dogAge: Int = calculateAge(from: birthDate) ?? 0
        
        let dog = Dog(
            profilePicture: data["profilePicture"] as? String ?? "",
            picture1: data["picture1"] as? String ?? "",
            picture2: data["picture2"] as? String ?? "",
            name: data["name"] as? String ?? "Unnamed",
            breed: data["breed"] as? String ?? "",
            birthday: "\(dogAge/12) yr \(dogAge%12) mo",
            gender: data["gender"] as? String ?? "",
            vaccine: data["vaccine"] as? String ?? "",
            stamboom: data["stamboom"] as? String ?? "",
            medicalRecord: data["medicalRecord"] as? String ?? "",
            location: data["location"] as? String ?? "",
            latitude: data["latitude"] as? String ?? "",
            longitude: data["longitude"] as? String ?? "",
            personality: newPersonality,
            weight: data["weight"] as? Float ?? 0.0,
            isReadyToBreed: data["isReadyToBreed"] as? Bool ?? false,
            isMedicalVerified: data["isMedicalVerified"] as? Bool ?? false,
            isVaccineVerified: data["isVaccineVerified"] as? Bool ?? false,
            isStamboomVerified: data["isStamboomVerified"] as? Bool ?? false,
            contact: data["contact"] as? String ?? ""
        )
        
        return dog
    }
    
    func fetchDogs() async {
        do {
            let querySnapshot = try await db.collection("dog").getDocuments()
            await fetchDogByID()
            var newDogs: [Dog] = []
            
            for document in querySnapshot.documents {
                let data = document.data()
                if document.documentID != registeredDogID{
                    if  data["gender"] as! String != myDog.gender{
                        var newPersonality: [Personality] = []
                        for personality in data["personality"] as? [String] ?? [] {
                            newPersonality.append(Personality(value: personality))
                        }
                        
                        let birthDate: Date = convertToDate(dateString: data["birthday"] as? String ?? "") ?? Date()
                        let dogAge: Int = calculateAge(from: birthDate) ?? 0
                        
                        newDogs.append(Dog(
                            profilePicture: data["profilePicture"] as? String ?? "",
                            picture1: data["picture1"] as? String ?? "",
                            picture2: data["picture2"] as? String ?? "",
                            name: data["name"] as? String ?? "Unnamed",
                            breed: data["breed"] as? String ?? "",
                            birthday: "\(dogAge/12) yr \(dogAge%12) mo",
                            gender: data["gender"] as? String ?? "",
                            vaccine: data["vaccine"] as? String ?? "",
                            stamboom: data["stamboom"] as? String ?? "",
                            medicalRecord: data["medicalRecord"] as? String ?? "",
                            location: data["location"] as? String ?? "",
                            latitude: data["latitude"] as? String ?? "",
                            longitude: data["longitude"] as? String ?? "",
                            personality: newPersonality,
                            weight: data["weight"] as? Float ?? 0.0,
                            isReadyToBreed: data["isReadyToBreed"] as? Bool ?? false,
                            isMedicalVerified: data["isMedicalVerified"] as? Bool ?? false,
                            isVaccineVerified: data["isVaccineVerified"] as? Bool ?? false,
                            isStamboomVerified: data["isStamboomVerified"] as? Bool ?? false,
                            contact: data["contact"] as? String ?? ""
                        ))
                    }
                }
            }
            
            self.fetchedDogs = newDogs
            
        } catch {
            print("Error getting documents: \(error)")
        }
    }
    
    func updateDog(uuid: String, imageName: ImageType, value: String){
        do {
            let updateRef = Firestore.firestore().collection("dog").document(uuid)
            let updateData = ["\(imageName)": value]
            updateRef.updateData(updateData) { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Image name successfully updated!")
                }
            }
        }
    }
    
    func updateDocument(fileUrl: URL, imageName: ImageType, uuid: String){
        do {
            let fileExtension = fileUrl.pathExtension
            var urls = ""
            let metadata = StorageMetadata()
            metadata.contentType = "image/\(fileExtension)"
            let storageReference = Storage.storage().reference().child("\(imageName)/\(UUID().uuidString).\(fileExtension)")
            if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "com.daudhiyaa.DogMitch") {
                let bookmarkData = try? fileUrl.bookmarkData()
                if let datas = bookmarkData{
                    var stale = false
                    if let url = try? URL(resolvingBookmarkData: datas, bookmarkDataIsStale: &stale),
                       stale == false,
                       url.startAccessingSecurityScopedResource() {
                        if let data = try? Data(contentsOf: fileUrl){
                            let uiImage: UIImage = UIImage(data: data)!
                            let compress = uiImage.jpegData(compressionQuality: 0.001)
                            print(compress!)
                            _ = storageReference.putData(compress!, metadata: metadata,completion: { (metadata,error) in
                                guard metadata != nil else{
                                    return
                                }
                                storageReference.downloadURL { url, error in
                                    if error != nil {
                                        return
                                    }
                                    urls = url!.description
                                    print("Url",urls)
                                    self.updateDog(uuid: uuid, imageName: imageName, value: urls)
                                    self.uploadStatus = "Success"
                                }
                            }
                            )
                        }
                        let filename = fileUrl.lastPathComponent
                        
                        print("Data Byte",datas)
                        print("filename",filename)
                    }
                    fileURL.stopAccessingSecurityScopedResource()
                } else {
                    print("Failed to obtain access to the security-scoped resource.")
                }
            }
        }
    }
    
    func uploadFile(fileUrl: URL, imageName: ImageType){
        do {
            let fileExtension = fileUrl.pathExtension
            var urls = ""
            let metadata = StorageMetadata()
            metadata.contentType = "image/\(fileExtension)"
            let storageReference = Storage.storage().reference().child("\(imageName)/\(UUID().uuidString).\(fileExtension)")
            
            if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "com.daudhiyaa.DogMitch") {
                let bookmarkData = try? fileUrl.bookmarkData()
                
                if let datas = bookmarkData{
                    var stale = false
                    
                    if let url = try? URL(resolvingBookmarkData: datas, bookmarkDataIsStale: &stale),
                       stale == false,
                       url.startAccessingSecurityScopedResource() {
                        if let data = try? Data(contentsOf: fileUrl){
                            let uiImage: UIImage = UIImage(data: data)!
                            let compress = uiImage.jpegData(compressionQuality: 0.001)
                            _ = storageReference.putData(compress!, metadata: metadata,completion: { (metadata,error) in
                                guard metadata != nil else{
                                    return
                                }
                                storageReference.downloadURL { url, error in
                                    if error != nil {
                                        return
                                    }
                                    urls = url!.description
                                    print("Url",urls)
                                    switch imageName {
                                    case .profilePicture:
                                        self.dogs.profilePicture = urls
                                        self.uploadCountInfo += 1
                                        if self.uploadCountInfo == self.uploadCheckerInfo.count{
                                            self.uploadStatus = "Success"
                                        }
                                    case .picture1:
                                        self.dogs.picture1 = urls
                                        self.uploadCountInfo += 1
                                        if self.uploadCountInfo == self.uploadCheckerInfo.count{
                                            self.uploadStatus = "Success"
                                        }
                                    case .picture2:
                                        self.dogs.picture2 = urls
                                        self.uploadCountInfo += 1
                                        if self.uploadCountInfo == self.uploadCheckerInfo.count{
                                            self.uploadStatus = "Success"
                                        }
                                    case .stamboom:
                                        print(self.uploadCheckerMedical.count)
                                        self.dogs.stamboom = urls
                                        self.uploadCountMedical += 1
                                        if self.uploadCountMedical == self.uploadCheckerMedical.count{
                                            self.uploadStatus = "Success"
                                        }
                                    case .medicalRecord:
                                        self.dogs.medicalRecord = urls
                                        print(self.uploadCheckerMedical.count)
                                        self.uploadCountMedical += 1
                                        if self.uploadCountMedical == self.uploadCheckerMedical.count{
                                            self.uploadStatus = "Success"
                                        }
                                    case .vaccine:
                                        self.dogs.vaccine = urls
                                        print(self.uploadCheckerMedical.count)
                                        self.uploadCountMedical += 1
                                        
                                        if self.uploadCountMedical == self.uploadCheckerMedical.count{
                                            self.uploadStatus = "Success"
                                            print("tes sini")
                                        }
                                    }
                                }
                            } )
                        }
                        let filename = fileUrl.lastPathComponent
                        
                        print("Data Byte", datas)
                        print("filename", filename)
                    }
                    fileURL.stopAccessingSecurityScopedResource()
                } else {
                    print("Failed to obtain access to the security-scoped resource.")
                }
            }
        }
    }
}

