//
//  ProfileView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

let pageStates: [String] = ["About", "Medical"]

struct ProfileHeader: View {
    @Binding var showAlert: Bool
    @Binding var isLoading: Bool

    var dog: Dog
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: dog.profilePicture)){ result in
                    result.image?
                        .resizable()
                        .scaledToFill()
                }
//                AsyncImage(url: URL(string: dog.profilePicture)) { phase in
//                    switch phase {
//                    case .empty:
//                        EmptyView()
//                    case .success(let image):
//                        image
//                            .resizable()
//                            .scaledToFill()
//                            .onAppear {
//                                isLoading = false
//                            }
//                    case .failure:
//                        Image(systemName: "exclamationmark.triangle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .foregroundColor(.red)
//                            .onAppear {
//                                isLoading = true
//                            }
//                    @unknown default:
//                        EmptyView()
//                            .onAppear {
//                                isLoading = true
//                            }
//                    }
//                }
                .centerCropped()
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                
                Image(dog.gender)
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
                HStack{
                    Text(dog.name).font(.title)
                    Button {
                        if !dog.isReadyToBreed {
                            showAlert = true
                        }
                    } label: {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(dog.isReadyToBreed ? .yellow : .gray.opacity(0.3))
                    }
                }
                Text(dog.location).font(.subheadline)
                Link(destination: URL(string: "https://api.whatsapp.com/send?phone=\(dog.contact)")!) {
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chat Owner")
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
    @EnvironmentObject var dogViewModel: DogViewModel
    
    @State private var pageState: String = "About"
    @State private var showAlert = false
    @State private var isLoading = true
    
    @State var dog: Dog
    var isMyProfile: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // PROFILE IMAGE
                ProfileHeader(
                    showAlert: $showAlert,
                    isLoading: $isLoading,
                    dog: dog
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
                    MedicalView(dog: dog, isMyProfile: isMyProfile)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .padding(24)
            .overlay(content: {
                if isLoading {
                    LoadingView()
                }
            })
            .navigationBarTitle("Profile", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Not Verified"),
                    message: Text("Upload & verify all medical document"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .task {
            if isMyProfile{
                await dogViewModel.fetchDogs()
                dog = dogViewModel.fetchedDogs[0]
                isLoading = false
            }
        }
    }
}

#Preview {
    ProfileView(dog: Dog.sampleDogList[1])
}
