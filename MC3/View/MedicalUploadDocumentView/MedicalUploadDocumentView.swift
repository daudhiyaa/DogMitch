
//  MedicalDocumentView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct MedicalUploadDocumentView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    @State private var isNavigationActive = false
    @State private var isImageUploading = false
    @State private var isImagePickerPresentedMedical = false
    @State private var isImagePickerPresentedVaccine = false
    @State private var isImagePickerPresentedStamboom = false
    @State private var totalProgress: Double = 0.0
    @State private var MedicalImage: URL?
    @State private var VaccineImage: URL?
    @State private var StamboomImage: URL?
    var dog: Dog
    
    var isFormValid: Bool {
        return MedicalImage != nil && VaccineImage != nil
    }
    @State private var uploadStatus: String?
    
    var body: some View {
            NavigationStack {
                VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            medicalRecordSection
                            vaccineBookSection
                            stamboomSection
                        }
                        .padding(18)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            isNavigationActive = true
                        }) {
                            Text("Later")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(Color(hex: "#D9D9D9"))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            dogViewModel.dogs = dog
                            print(dogViewModel.dogs.profilePicture)
                            isImageUploading = true
                            
                            if MedicalImage != nil && VaccineImage != nil {
                                dogViewModel.uploadCheckerMedical.append(contentsOf: ["medicalRecord", "vaccine"])
                            } else {
                                dogViewModel.uploadCheckerMedical.append(contentsOf: ["medicalRecord", "vaccine", "stamboom"])
                            }
                            
                            if let url = MedicalImage{
                                dogViewModel.uploadFile(fileUrl: url, imageName: .medicalRecord)
                            }
                            if let url = VaccineImage{
                                dogViewModel.uploadFile(fileUrl: url, imageName: .vaccine)
                            }
                            if let url = StamboomImage{
                                dogViewModel.uploadFile(fileUrl: url, imageName: .stamboom)
                            }
                         
                            print("medical:\(dogViewModel.dogs)")
                        }) {
                            Text("Upload")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .background(isFormValid ? Colors.tosca : Color(hex: "#D9D9D9"))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }
                        .disabled(!isFormValid)
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 16)
                }
                .navigationBarTitle("Health Verification", displayMode: .inline)
                .overlay(content: {
                    if isImageUploading{
                        LoadingView()
                        
                        if let upload =  dogViewModel.uploadStatus {
                            Text(upload).hidden()
                                .onAppear{
                                    dogViewModel.addDog(newDog: dogViewModel.dogs)
                                    isNavigationActive = true
                                }
                        }
                    }
                }) 
                .navigationDestination(
                isPresented: $isNavigationActive) {
                    MainView(dogBreed: dog.breed)
                    Text("Continue?")
                        .hidden()
                }
            .sheet(isPresented: $isImagePickerPresentedMedical) {
                ImagePicker(selectedImage: $MedicalImage)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $isImagePickerPresentedVaccine) {
                ImagePicker(selectedImage: $VaccineImage)
                    .ignoresSafeArea()
            }
            .sheet(isPresented: $isImagePickerPresentedStamboom) {
                ImagePicker(selectedImage: $StamboomImage)
                    .ignoresSafeArea()
            }
        }
    }
        
        private var medicalRecordSection: some View {
            VStack {
                Text("Medical Record")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Help others identify how healthy your dog is.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let image = MedicalImage {
                    resizableImage(image: image)
                        .onTapGesture {
                            self.isImagePickerPresentedMedical.toggle()
                        }
                } else {
                    placeholderButton(action: { self.isImagePickerPresentedMedical.toggle() })
                }
            }
        }
        
        private var vaccineBookSection: some View {
            VStack {
                Text("Vaccine Book")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Help others identify the vaccination status of your dog.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let image = VaccineImage {
                    resizableImage(image: image)
                        .onTapGesture {
                            self.isImagePickerPresentedVaccine.toggle()
                        }
                } else {
                    placeholderButton(action: { self.isImagePickerPresentedVaccine.toggle() })
                }
            }
        }
        
        private var stamboomSection: some View {
            VStack {
                Text("Pedigree Paper (Stamboom)")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Help others identify the lineage of your dog.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let image = StamboomImage {
                    resizableImage(image: image)
                        .onTapGesture {
                            self.isImagePickerPresentedStamboom.toggle()
                        }
                } else {
                    placeholderButton(action: { self.isImagePickerPresentedStamboom.toggle() })
                }
            }
        }
        
        private func resizableImage(image: URL) -> some View {
            AsyncImage(url: image){ result in
                result.image?
                    .resizable()
                    .scaledToFill()
            }
            .centerCropped()
            .scaledToFit()
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .clipped()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.teal)
            )
            .padding(.bottom, 16)
        }
        
        private func placeholderButton(action: @escaping () -> Void) -> some View {
            Button(action: action) {
                VStack {
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.teal)
                }
                .padding()
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .foregroundColor(.teal)
                )
                .cornerRadius(16)
            }
        }
    }

#Preview {
    MedicalUploadDocumentView(dog: Dog.sampleDogList[1])
}
