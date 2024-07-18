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
                                    if selected==name{
                                        SelectBreedCard(name: name,  isChosen: false)
                                    }else{
                                        SelectBreedCard(name: name,  isChosen: true)
                                    }
                                }
                            }.padding(.top)
                        }
                        .padding(.top,8)
                    }
                }
                VStack{
                    if selected.isEmpty{
                        Button(action: {
                            // ACTION
                        }) {
                            Text("Next") .font(.system(size: 17)).fontWeight(.semibold)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding(12)
                                .background(Color(hex: "#D9D9D9"))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }else{
                        Button(action: {
                            // ACTION
                            print(selected)
                        }) {
                            Text("Next") .font(.system(size: 17)).fontWeight(.semibold)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding(12)
                                .background(Colors.tosca)
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }
                    }
                }
            }.padding(18)
                .navigationBarTitle("Select Your Dog Breed", displayMode: .inline)
        }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
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

