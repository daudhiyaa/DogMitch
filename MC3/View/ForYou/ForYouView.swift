//
//  ForYouView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct ForYouView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(dogViewModel.showDogs) { dog in
                        NavigationLink(
                            destination: ProfileView(dog: dog),
                            label: {
                                ForYouCard(dog: dog)
                            })
                    } .listRowSeparator(.hidden)
                }
            }.padding(.bottom,30)
            VStack(alignment: .leading, spacing: 20) {
                VStack{
                    Button(action: {
                        // ACTION
                        let dog =  Dog(profilePicture: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", picture1: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", picture2: "https://www.akc.org/wp-content/uploads/2020/07/Golden-Retriever-puppy-standing-outdoors-500x486.jpg", name: "Blacky", breed: "Golden Retriever", birthday: "24 mo", gender: "male", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute"), Personality(value: "Smart"), Personality(value: "Sharp"), Personality(value: "Quiet"), Personality(value: "Small")], weight: 3.5, readyToBreed: true, contact: "081223445667")
                        dogViewModel.addDog(newDog: dog)
                    }) {
                        HStack {
                            Image(systemName: "map")
                            Text("See Dog Nearby") .font(.system(size: 17)).fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(15)
                        .background(Colors.tosca)
                        .cornerRadius(15)
                        .foregroundColor(.white)
                    }
                }
            }
            .padding(24)
            .navigationBarTitle("Dog Tinder", displayMode: .inline)
        }
    }
}

#Preview {
    ForYouView().environmentObject(DogViewModel())
}
