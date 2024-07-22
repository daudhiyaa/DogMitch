//
//  DogViewModel.swift
//  MC3
//
//  Created by Marsha Likorawung on 17/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class DogViewModel: ObservableObject{
    @Published var dog = [Dog]()
    @Published var dogs = Dog.emptyDog
    @Published var image = ""
    
    init(){
        dog = Dog.sampleDogList
    }
    
    var showDogs: [Dog] {
        return dog
    }
    
    func addDog(newDog: Dog){
        let collection = Firestore.firestore().collection("dog")
        collection.addDocument(data: newDog.dictionary)
        dog.append(newDog)
    }
    
    enum ImageType {
        case profilePicture
        case picture1
        case picture2
        case stamboom
        case medicalRecord
        case vaccine
    }
    
    func uploadFile(fileUrl: URL, imageName: ImageType){
        do {
            let fileExtension = fileUrl.pathExtension
            let fileName = "images.\(fileExtension)"
            var urls = ""
            let metadata = StorageMetadata()
            metadata.contentType = "image/png"
            let storageReference = Storage.storage().reference().child("images/\(UUID().uuidString).png")
            if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "com.daudhiyaa.DogMitch") {
                if fileUrl.startAccessingSecurityScopedResource() {
                    if let data = try? Data(contentsOf: fileUrl){
                        let filename = fileUrl.lastPathComponent
                        let uploadTask = storageReference.putData(data, metadata: metadata,completion: { (metadata,error) in
                            guard let metadata = metadata else{
                                return
                            }
                            storageReference.downloadURL { url, error in
                                if let error = error {
                                    return
                                }
                                urls = url!.description
                                print("Url",urls)
                                switch imageName {
                                case .profilePicture:
                                    self.dogs.profilePicture = urls
                                case .picture1:
                                    self.dogs.picture1 = urls
                                case .picture2:
                                    self.dogs.picture2 = urls
                                case .stamboom:
                                    self.dogs.stamboom = urls
                                case .medicalRecord:
                                    self.dogs.medicalRecord = urls
                                case .vaccine:
                                    self.dogs.vaccine = urls
                                    
                                }
                            }
                        } )
                        print("Data Byte",data)
                        print("filename",filename)
                    }
                    fileURL.stopAccessingSecurityScopedResource()
                } else {
                    print("Failed to obtain access to the security-scoped resource.")
                }
            }
        }
    }
}
