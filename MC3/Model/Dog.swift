//
//  Dog.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import Foundation

struct Dog: Identifiable{
    var id : UUID
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
    var latitude: String
    var longitude: String
    var personality: [Personality]
    var weight: Float
    var isReadyToBreed: Bool
    var isMedicalVerified: Bool
    var isVaccineVerified: Bool
    var isStamboomVerified: Bool
    var contact: String
    
    init(id: UUID  = UUID(), profilePicture: String,picture1: String,picture2: String, name: String, breed: String, birthday: String, gender: String, vaccine: String,  stamboom: String, medicalRecord: String, location: String,latitude: String,longitude: String, personality: [Personality],  weight: Float, isReadyToBreed: Bool, isMedicalVerified: Bool,isVaccineVerified: Bool,isStamboomVerified: Bool, contact: String) {
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
        self.latitude = latitude
        self.longitude = longitude
        self.personality = personality
        self.weight = weight
        self.isReadyToBreed = isReadyToBreed
        self.isMedicalVerified = isMedicalVerified
        self.isVaccineVerified = isVaccineVerified
        self.isStamboomVerified = isStamboomVerified
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
            "latitude" : latitude,
            "longitude" : longitude,
            "personality" : personality.map { $0.value },
            "weight" : weight,
            "isReadyToBreed" : isReadyToBreed,
            "isMedicalVerified" : isMedicalVerified,
            "isVaccineVerified" : isVaccineVerified,
            "isStamboomVerified" : isStamboomVerified,
            "contact" : contact,
       ]
    }
}
