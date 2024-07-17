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
            DogsMateView().tabItem {
                Label("Dog's Mate", systemImage: "pawprint")
            }
            
            ForYouView().tabItem {
                Label("For You", systemImage: "hands.and.sparkles")
            }.environmentObject(DogViewModel())
            
            ProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}

#Preview {
    ContentView()
}
