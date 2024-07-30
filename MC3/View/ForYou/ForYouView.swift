//
//  ForYouView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct ForYouView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    @AppStorage("registeredDogBreed") private var registeredDogBreed: String?
    @State private var isLoading = false
    @State var dogs : [Dog]
    
    var body: some View {
        NavigationView{
            ForYouSwipe(dogs : $dogs)
                .navigationBarTitle("For You", displayMode: .inline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(content: {
                    if isLoading {
                        LoadingView()
                    }
                })
                .task {
                    isLoading = true
                    await dogViewModel.fetchDogs()
                    dogs = dogViewModel.fetchedDogs
                    isLoading = false
                }
        }
    }
}
