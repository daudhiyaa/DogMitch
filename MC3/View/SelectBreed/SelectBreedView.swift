//
//  SelectBreedView.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI

struct SelectBreedView: View {
    let dogBreed = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Siberian Husky", "Pomeranian", "Australian Shepherd", "Chihuahua", "Toy Poodle", "Miniature Poodle","Standard Poodle","Dachshund", "Pug", "Rottweiler", "Maltese", "Corgi"]
    
    @State private var selected: String = ""
    @State private var searchText = ""
    
    @State private var isNavigationActive = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                if (searchText != "" && dogBreed.filter { $0.contains(searchText)}.count == 0){
                    ContentUnavailableView.search
                }else{
                    ScrollView(){
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(searchResults, id: \.self) { name in
                                Button(action: {
                                    selected = name
                                }) {
                                    if selected == name{
                                        SelectBreedCard(name: name,  isChosen: false)
                                    }else{
                                        SelectBreedCard(name: name,  isChosen: true)
                                    }
                                }
                            }.padding(.top)
                        }.padding(.top,8)
                    }
                }
                VStack{
                    Button(action: {
                        isNavigationActive = true
                    }) {
                        Text("Next") .font(.system(size: 17)).fontWeight(.semibold)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding(12)
                            .background(selected.isEmpty ? Color(hex: "#D9D9D9") : Colors.tosca)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                    }.disabled(selected.isEmpty)
                }
            }
            .padding(18)
            .navigationBarTitle("Select Your Dog Breed", displayMode: .inline)
            .overlay {
                NavigationLink("select-breed-dog", destination: DogsInformationView(dogBreed: selected), isActive: $isNavigationActive).hidden()
            }
        }
        .searchable(
            text: $searchText,
            placement:.navigationBarDrawer(displayMode: .always)
        )
    }
    var searchResults: [String] {
        if searchText.isEmpty {
            return dogBreed
        } else {
            return dogBreed.filter { $0.contains(searchText) }
        }
    }
}

#Preview {
    SelectBreedView()
}

