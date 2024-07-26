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
    var isMyProfile: Bool
    @State var isReadyToBread: Bool = false
    
    var profileState: VerificationState
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ZStack(alignment: .bottomTrailing) {
                AsyncImage(url: URL(string: dog.profilePicture)){ image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
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
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(dog.isReadyToBreed ? .yellow : .gray.opacity(0.3))
                }
                
                Text(dog.location).font(.subheadline)
                Spacer().frame(height: 8)
                
                if isMyProfile {
                    if profileState == .verified {
                        HStack {
                            Text("Ready to Breed")
                                .fontWeight(.bold)
                            Spacer()
                            Toggle(isOn: $isReadyToBread) {
                                EmptyView()
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                    }
                    else {
                        HStack(alignment: .top) {
                            Image(systemName: profileStatusIcon)
                                .foregroundColor(.red)
                            Text(profileStatusMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                else{
                    if profileState == .verified {
                        Link(destination: URL(string: "https://api.whatsapp.com/send?phone=\(dog.contact)")!) {
                            ButtonChatOwner()
                        }
                    } else {
                        Button {
                            if !dog.isReadyToBreed {
                                showAlert = true
                            }
                        } label: {
                            ButtonChatOwner()
                        }
                    }
                }
            }
        }
    }
    
    var profileStatusIcon: String {
        switch profileState {
        case .waitingVerification:
            return "clock"
        default:
            return "exclamationmark.triangle"
        }
    }
    
    var profileStatusMessage: String {
        switch profileState {
        case .notUploaded:
            return "You haven't uploaded any medical document."
        case .waitingVerification:
            return "Your account will be verified within a maximum of 24 hours."
        case .medicalRejected:
            return "Your medical document is rejected."
        case .vaccineRejected:
            return "Your vaccine document is rejected."
        case .stamboomRejected:
            return "Your stamboom document is rejected."
        default:
            return "Your profile is verified."
        }
    }
}

struct ProfileView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    
    @State private var pageState: String = "About"
    @State private var showAlert = false
    @State private var isLoading = false
    
    @State var dog: Dog
    var isMyProfile: Bool = true

    var profileState: VerificationState {
        checkProfileState()
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // PROFILE IMAGE
                ProfileHeader(
                    showAlert: $showAlert,
                    isLoading: $isLoading,
                    dog: dog,
                    isMyProfile: isMyProfile,
                    profileState: profileState
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
                    if profileState == .notUploaded {
                        NotUploadedView()
                    }
                    else if profileState == .waitingVerification {
                        WaitingVerificationView()
                    }
                    else {
                        MedicalView(dog: dog, isMyProfile: isMyProfile)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .padding(24)
            .overlay(content: {
                if isLoading {
                    LoadingView()
                }
            })
            .frame(maxHeight: .infinity, alignment: .topLeading)
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
                isLoading = true
                await dogViewModel.fetchDogs()
                dog = dogViewModel.fetchedDogs[0]
                isLoading = false
            }
        }
    }
    
    func checkProfileState() -> VerificationState {
        if dog.medicalRecord == "" && dog.vaccine == "" {
            return .notUploaded
        } else if (dog.medicalRecord != "" && dog.vaccine != "") && (!dog.isMedicalVerified && !dog.isVaccineVerified) {
            return .waitingVerification
        } else if !dog.isMedicalVerified && dog.isVaccineVerified {
            return .medicalRejected
        } else if dog.isMedicalVerified && !dog.isVaccineVerified {
            return .vaccineRejected
        } else if dog.stamboom != "" && !dog.isStamboomVerified {
            return .stamboomRejected
        }
        return .verified
    }
}

struct NotUploadedView: View {
    var body: some View {
        VStack {
            Image("medical_document_state")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text("Oops, you haven’t complete your dog’s health verification")
                .font(.title3)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .padding(.bottom, 3.0)
            Text("To gain the trust of other dog owners, please verify your dog's health.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Button {
                //
            } label: {
                Text("Complete Now")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(10)
            .background(Colors.tosca)
            .cornerRadius(24)
        }
    }
}

struct WaitingVerificationView: View {
    var body: some View {
        VStack {
            Image("medical_document_state")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
            Text("Your account will be verified within a maximum of 24 hours.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .padding(.bottom, 3.0)
        }
    }
}

struct ButtonChatOwner: View {
    var body: some View {
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
