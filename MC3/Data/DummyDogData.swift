//
//  DummyDogData.swift
//  MC3
//
//  Created by Daud on 18/07/24.
//

import Foundation

extension Dog{
    static let sampleDogList: [Dog] = [
        Dog(profilePicture: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", picture1: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", picture2: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", name: "Blacky", breed: "Golden Retriever", birthday: "24 mo", gender: "male", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667"),
        Dog(profilePicture: "https://www.pdsa.org.uk/media/7646/golden-retriever-gallery-2.jpg?anchor=center&mode=crop&quality=100&height=500&bgcolor=fff&rnd=133020229510000000",picture1: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", picture2: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", name: "Momo", breed: "Golden Retriever", birthday: "24 mo", gender: "female", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small"),Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667"),
        Dog(profilePicture: "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2021/08/20065849/Ini-X-Gangguan-Kesehatan-yang-Umumnya-Dialami-Anjing-Golden.jpg.webp",picture1: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", picture2: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", name: "Perry Platypus", breed: "Golden Retriever", birthday: "24 mo", gender: "female", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667")
    ]
    
    static let emptyDog: Dog =
        Dog(profilePicture: "", picture1: "", picture2: "", name: "", breed: "", birthday: "", gender: "", vaccine: "", stamboom: "", medicalRecord: "", location: "", personality: [], weight: 0, readyToBreed: false, contact: "")
}
