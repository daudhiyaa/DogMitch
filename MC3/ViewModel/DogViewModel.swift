//
//  DogViewModel.swift
//  MC3
//
//  Created by Marsha Likorawung on 17/07/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

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
    @Published  var uploadStatus: String?
    @Published  var uploadCheckerInfo: [String] = []
    @Published  var uploadCheckerMedical: [String] = []
    @Published  var uploadCountInfo: Int = 0
    @Published  var uploadCountMedical: Int = 0
    
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
                                    case .vaccine:
                                        self.dogs.vaccine = urls
                                        print(self.uploadCheckerMedical.count)
                                        self.uploadCountMedical += 1
                                        print(self.uploadCountMedical)
                                        if self.uploadCountMedical == self.uploadCheckerMedical.count{
                                            self.uploadStatus = "Success"
                                        }
                                    }
                                }
                            } )
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
}
