//
//  MedicalDocumentView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct MedicalDocumentView: View {
    var pageTitle: String
    var documentImage: String
    var verificationStatusMessage: String
    var verificationStatusIcon: String
    @AppStorage("registeredDogID") private var registeredDogID: String = "invalid_id"
    @EnvironmentObject var dogViewModel: DogViewModel
    @State private var isImagePickerPresented = false
    @State private var selectedImages: URL?
    @State private var isImageUploading = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading, spacing: 8) {
                ZStack (alignment: .topTrailing) {
                        if let image = selectedImages {
                            AsyncImage(url: image){ result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                            }
                            .cornerRadius(10)
                            .onAppear{
                                isImageUploading = true
                                if let url = selectedImages{
                                    if pageTitle == menuItems[0] {
                                        dogViewModel.updateDocument(fileUrl: url, imageName: .vaccine, uuid: registeredDogID)
                                    }else if pageTitle == menuItems[1]{
                                        dogViewModel.updateDocument(fileUrl: url, imageName: .stamboom, uuid: registeredDogID)
                                    }else{
                                        dogViewModel.updateDocument(fileUrl: url, imageName: .medicalRecord, uuid: registeredDogID)
                                    }
                                }
                            }
                        } else {
                            AsyncImage(url: URL(string: documentImage)){ image in
                                image.resizable()
                                    .scaledToFit()
                            }placeholder: {
                                ProgressView()
                            }
                            .cornerRadius(10)
                        }
                    
                    Button (action: {
                        self.isImagePickerPresented.toggle()
                    }, label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundStyle(.teal)
                            .aspectRatio(contentMode: .fit)
                            .padding(8)
                            .background(.white)
                            .clipShape(Circle())
                            .offset(x: -10, y: 10)
                            .shadow(radius: 10)
                    })
                }
                
                if !verificationStatusMessage.contains("verified") {
                    HStack(alignment: .top) {
                        Image(systemName: verificationStatusIcon)
                            .foregroundColor(.red)
                        Text(verificationStatusMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .topLeading)
            .overlay(content: {
                if isImageUploading{
                    ZStack {
                        Color(white: 0, opacity: 0.75)
                        ProgressView().tint(.white)
                    }.ignoresSafeArea()
                    if let upload =  dogViewModel.uploadStatus {
                        Text(upload).hidden()
                            .onAppear{
                                isImageUploading = false
                            }
                        
                    }
                }
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImages)
            }
            .padding(24)
            .navigationBarTitle(pageTitle, displayMode: .inline)
        }
    }
}

#Preview {
    MedicalDocumentView(
        pageTitle: "Dummy Title",
        documentImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s",
        verificationStatusMessage: "Warning",
        verificationStatusIcon: "x.circle"
    )
}
