//
//  ContentView.swift
//  MC3
//
//  Created by Daud on 12/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            ForYouView().tabItem {
                Label("For You", systemImage: "hands.and.sparkles")
            }.environmentObject(DogViewModel())
            
            ProfileView(dog: Dog.sampleDogList[0], isMyProfile: true).tabItem {
                Label("Profile", systemImage: "person")
            }.environmentObject(DogViewModel())
        }
    }
}

#Preview {
    SelectBreedView()
}
