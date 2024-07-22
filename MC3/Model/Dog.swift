//
//  Dog.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import Foundation

struct Dog: Identifiable{
    let id : UUID
    var profilePicture : String
    var picture1 : String
    var picture2 : String
    var name : String
    var breed : String
    var birthday : String
    var gender : String
    var vaccine: String
    var stamboom: String
    var medicalRecord: String
    var location: String
    var personality: [Personality]
    var weight: Float
    var readyToBreed: Bool
    var contact: String
    
    init(id: UUID  = UUID(), profilePicture: String,picture1: String,picture2: String, name: String, breed: String, birthday: String, gender: String, vaccine: String,  stamboom: String, medicalRecord: String, location: String, personality: [Personality],  weight: Float, readyToBreed: Bool, contact: String) {
        self.id = id
        self.profilePicture = profilePicture
        self.picture1 = picture1
        self.picture2 = picture2
        self.name = name
        self.breed = breed
        self.birthday = birthday
        self.gender = gender
        self.vaccine = vaccine
        self.stamboom = stamboom
        self.medicalRecord = medicalRecord
        self.location = location
        self.personality = personality
        self.weight = weight
        self.readyToBreed = readyToBreed
        self.contact = contact
    }
    
    var dictionary: [String: Any] {
       return [
            "profilePicture" : profilePicture,
            "picture1" : picture1,
            "picture2" : picture2,
            "name" : name,
            "breed" : breed,
            "birthday" : birthday,
            "gender" : gender,
            "vaccine" : vaccine,
            "stamboom" : stamboom,
            "medicalRecord" : medicalRecord,
            "location" : location,
            "personality" : personality.map { $0.value },
            "weight" : weight,
            "readyToBreed" : readyToBreed,
            "contact" : contact,
       ]
    }
}
