//
//  DogViewModel.swift
//  MC3
//
//  Created by Marsha Likorawung on 17/07/24.
//

import Foundation
import FirebaseFirestore

class DogViewModel: ObservableObject{
    @Published var dog = [Dog]()

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
}
