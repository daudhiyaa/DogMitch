//
//  Dog.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import Foundation

struct Dog: Identifiable{
    let id : UUID
    var picture : String
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
    
    init(id: UUID  = UUID(), picture: String, name: String, breed: String, birthday: String, gender: String, vaccine: String,  stamboom: String, medicalRecord: String, location: String, personality: [Personality],  weight: Float, readyToBreed: Bool, contact: String) {
        self.id = id
        self.picture = picture
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
        "picture" : picture,
        "name" : name,
        "breed" : breed,
        "birthday" : birthday,
        "gender" : gender,
        "vaccine" : vaccine,
        "stamboom" : stamboom,
        "medicalRecord" : medicalRecord,
        "location" : location,
        "personality" : "personality",
        "weight" : weight,
        "readyToBreed" : readyToBreed,
        "contact" : contact,
       ]
     }
}


//dummy data
extension Dog{
    static let sampleDogList: [Dog] =
    [
        Dog(picture: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", name: "Blacky", breed: "Golden Retriever", birthday: "24 Month Old", gender: "male", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667"),
        Dog(picture: "https://www.pdsa.org.uk/media/7646/golden-retriever-gallery-2.jpg?anchor=center&mode=crop&quality=100&height=500&bgcolor=fff&rnd=133020229510000000", name: "Momo", breed: "Golden Retriever", birthday: "24 Month Old", gender: "female", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667"),
        Dog(picture: "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/08/20065849/Ini-X-Gangguan-Kesehatan-yang-Umumnya-Dialami-Anjing-Golden.jpg.webp", name: "Perry Platypus", breed: "Golden Retriever", birthday: "24 Month Old", gender: "female", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667")
    ]
    
}
