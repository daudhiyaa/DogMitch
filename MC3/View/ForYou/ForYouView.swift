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
                            destination: ProfileView(),
                            label: {
                                ForYouCard( dog: dog)
                            })
                    } .listRowSeparator(.hidden)
                }
            }.padding(.bottom,30)
            VStack(alignment: .leading, spacing: 20) {
                VStack{
                    Button(action: {
                        // ACTION
                        let dog = Dog(picture: "https://www.pdsa.org.uk/media/7646/golden-retriever-gallery-2.jpg?anchor=center&mode=crop&quality=100&height=500&bgcolor=fff&rnd=133020229510000000", name: "Momo", breed: "Golden Retriever", birthday: "24 Month Old", gender: "female", vaccine: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s", stamboom: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkFtgdM0ZzLFoFlv6HpKpGMkuD0xK_lR0x2Q&s", medicalRecord: "https://files.jotform.com/jotformapps/pet-health-record-template-406e476de255618cc1abbe9fe515499c.png?v=1720792377", location: "CitraLand CBD Boulevard, Made, Kec. Sambikerep, Surabaya, Jawa Timur 60219", personality: [Personality(value: "Cute")], weight: 3.5, readyToBreed: true, contact: "081223445667")
                        dogViewModel.addDog(newDog: dog)
                    }) {
                        HStack {
                            Image(systemName: "map")
                            Text("See Dog Nearby") .font(.system(size: 17)).fontWeight(.semibold)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
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
