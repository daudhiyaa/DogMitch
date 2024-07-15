//
//  ForYouView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct ForYouView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(Dog.sampleDogList) { dog in
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
    ForYouView()
}
