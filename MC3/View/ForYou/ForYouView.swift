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
            }.padding(.bottom, 30)
//            VStack(alignment: .leading, spacing: 20) {
//                VStack{
//                    Button(action: {
//                        // ACTION
//                    }) {
//                        HStack {
//                            Image(systemName: "map")
//                            Text("See Dog Nearby") .font(.system(size: 17)).fontWeight(.semibold)
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(15)
//                        .background(Colors.tosca)
//                        .cornerRadius(15)
//                        .foregroundColor(.white)
//                    }
//                }
//            }
            .navigationBarTitle("For You", displayMode: .inline)
        }
    }
}

#Preview {
    ForYouView().environmentObject(DogViewModel())
}
