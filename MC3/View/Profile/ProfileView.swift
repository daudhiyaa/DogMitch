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
                Image(dogImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Image(systemName: dogGender == "Male" ? "pawprint" : "pawprint.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(dogGender == "Male" ? .teal : .red)
                    .aspectRatio(contentMode: .fit)
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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // PROFILE IMAGE
                ProfileHeader(
                    dogImage: "dog_profile",
                    dogName: "Puppy",
                    dogLocation: "Surabaya, Indonesia",
                    dogGender: "Male"
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
                    AboutView()
                } else {
                    MedicalView().clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(24)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

#Preview {
    ProfileView()
}
