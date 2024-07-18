//
//  ProfileView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

let pageStates: [String] = ["About", "Medical"]

struct ProfileHeader: View {
    var dogImage: String
    var dogName: String
    var dogLocation: String
    var dogGender: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: dogImage)){ result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
                .centerCropped()
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                
                Image(dogGender)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .padding(8)
                    .background(.white)
                    .clipShape(Circle())
                    .offset(x: 10, y: 10)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
        
            VStack(alignment: .leading) {
                Text(dogName).font(.title)
                Text(dogLocation).font(.subheadline)
                Button(action: {
                    // ACTION
                }) {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("See Dog Location")
                    }
                    .padding(10)
                    .background(Color.teal)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
    }
}

struct ProfileView: View {
    @State private var pageState: String = "About"
    
    var dog: Dog
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // PROFILE IMAGE
                ProfileHeader(
                    dogImage: dog.picture,
                    dogName: dog.name,
                    dogLocation: dog.location,
                    dogGender: dog.gender
                )
                
                // SEGMENTED CONTROLS
                Picker("Filter", selection: $pageState) {
                    ForEach(pageStates, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }
                .pickerStyle(.segmented)
                
                // PAGE CONTENT
                if pageState == "About" {
                    AboutView(dog: dog)
                } else {
                    MedicalView(dog: dog).clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(24)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

#Preview {
    ProfileView(dog: Dog.sampleDogList[1])
}
