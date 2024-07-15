//
//  SelectBreedView.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI

struct SelectBreedView: View {
    let dogBreed = ["Labrador Retriever", "German Shepherd"]
    @State private var searchText = ""
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                if (searchText != ""){
                    ContentUnavailableView.search
                }else{
                    ScrollView(){
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(searchResults, id: \.self) { name in
                                SelectBreedCard(name: name)
                            }.padding(.top)
                        }
                        .padding(.top)
                    }
                }
            }.padding(24)
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

