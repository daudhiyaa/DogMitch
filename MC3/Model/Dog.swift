//
//  Dog.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import Foundation

struct Dog : Identifiable, Codable {
    var id : UUID
    var picture : String
    var name : String
    var breed : String
    var age : String
    var gender : String
    
    init(id: UUID  = UUID(), picture: String, name: String, breed: String, age: String, gender: String) {
        self.id = id
        self.picture = picture
        self.name = name
        self.breed = breed
        self.age = age
        self.gender = gender
    }
}

//dummy data
extension Dog{
    static let sampleDogList: [Dog] =
    [
        Dog(picture: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", name: "Blacky", breed: "Golden Retriever", age: "24 Month Old", gender: "male"),
        Dog(picture: "https://www.pdsa.org.uk/media/7646/golden-retriever-gallery-2.jpg?anchor=center&mode=crop&quality=100&height=500&bgcolor=fff&rnd=133020229510000000", name: "Momo", breed: "Golden Retriever", age: "36 Month Old", gender: "female"),
        Dog(picture: "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/08/20065849/Ini-X-Gangguan-Kesehatan-yang-Umumnya-Dialami-Anjing-Golden.jpg.webp", name: "Perry Platypus", breed: "Golden Retriever", age: "39 Month Old", gender: "female")
        
    ]
    
}
