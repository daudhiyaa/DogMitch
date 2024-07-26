//
//  SelectBreedView.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI

struct SelectBreedView: View {
    let dogBreed = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Siberian Husky", "Pomeranian", "Australian Shepherd", "Chihuahua", "Toy Poodle", "Miniature Poodle","Standard Poodle","Dachshund", "Pug", "Rottweiler", "Maltese", "Corgi"]
    
    @State private var selectedDogBreed: String = ""
    @State private var searchText = ""
    
    @State private var isNavigationActive = false
    @State private var isKeyboardVisible: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                if (searchText != "" && dogBreed.filter  { $0.lowercased().contains(searchText.lowercased()) }.count == 0){
                    ContentUnavailableView.search
                        .contentShape(Rectangle())
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                }else{
                    ScrollView(){
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                            ForEach(searchResults, id: \.self) { name in
                                Button(action: {
                                    UIApplication.shared.endEditing()
                                    selectedDogBreed = name
                                }) {
                                    if selectedDogBreed == name{
                                        SelectBreedCard(name: name,  isChosen: false)
                                    }else{
                                        SelectBreedCard(name: name,  isChosen: true)
                                    }
                                }
                            }.padding(.top)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    UIApplication.shared.endEditing()
                                }
                        }.padding(.top,8)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                            }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                }
                if !isKeyboardVisible {
                    VStack{
                        Button(action: {
                            searchText = ""
                            isNavigationActive = true
                        }) {
                            Text("Next") .font(.system(size: 17)).fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(selectedDogBreed.isEmpty ? Color(hex: "#D9D9D9") : Colors.tosca)
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }.disabled(selectedDogBreed.isEmpty)
                    }
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .padding(.horizontal,18)
            .padding(.top,18)
            .padding(.bottom, !isKeyboardVisible ? 18 : 0)
            .navigationBarTitle("Select Your Dog Breed", displayMode: .inline)
            .navigationDestination(
                isPresented: $isNavigationActive) {
                    MainView(dogBreed: selectedDogBreed)
                        .navigationBarBackButtonHidden(true)
                }
        }
        .searchable(
            text: $searchText,
            placement:.navigationBarDrawer(displayMode: .always)
        )
        .onAppear {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                withAnimation {
                    isKeyboardVisible = true
                }
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                withAnimation {
                    isKeyboardVisible = false
                }
            }
        }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return dogBreed
        } else {
            let lowercasedSearchText = searchText.lowercased()
            return dogBreed.filter { $0.lowercased().contains(lowercasedSearchText) }
        }
    }

}

#Preview {
    SelectBreedView()
}

