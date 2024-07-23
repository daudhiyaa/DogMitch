//
//  DogsInformationView.swift
//  MC3
//
//  Created by Jeffri Lieca H on 16/07/24.
//

import SwiftUI
import UIKit
import Combine
import MapKit
import Photos

struct DogsInformationView: View {
    @State var dog: Dog?
    @EnvironmentObject var dogViewModel: DogViewModel
    var dogBreed: String
    @State private var isNavigationActive = false
    @State private var isImageUploading = false
    init(dogBreed : String){
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .selected)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().layer.cornerRadius = 20
        self.dogBreed = dogBreed
    }
    
    @State private var dogName = ""
    @State private var birthdayDate : Date?
    @State private var birthdayText = ""
    @State private var isComplete = false
    @State private var showDatePicker = false
    
//    @ObservedObject var weight = NumbersOnly()
    @State var weight = ""
    weak var dateTextField: UITextField!
    @State private var gender = 0
    var genderChoice = ["Male","Female"]
    
    // Personality
    @State private var isModalPresented = false
    @State private var searchText = ""
    @State private var selectedOption: String? = nil
    @State private var isShowingPersonalityList = false // State untuk menampilkan modal
    @State private var selectedPersonalities: [String] = []
    @State private var kosong = ""
    
    // Location
    @State private var isShowingLocationModal = false
    @State private var isShowingLocationModa2 = false
    @State private var city = ""
    @State private var dogLocation = ""
//    @State private var dogCoordinate : CLLocation = CLLocation()
    @State private var dogCoordinate : String = ""
    
    
    //Phone Number
    @State private var phoneNumber = ""
    @State var presentSheet = false
    @State var countryCode : String = "+62"
    @State var countryFlag : String = "🇮🇩"
    @State var countryPattern : String = "### ######"
    @State var countryLimit : Int = 17
    @State var mobPhoneNumber = ""
    @State private var searchCountry: String = ""
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var keyIsFocused: Bool
    
    // Image
    @State private var isImagePickerPresented1 = false
    @State private var isImagePickerPresented2 = false
    @State private var isImagePickerPresented3 = false
    @State private var selectedImages: URL?
    @State private var selectedImages1: URL?
    @State private var selectedImages2: URL?
    @State private var imageKe : Int = 4
    
    let personalities: [Personality] = [
        Personality(value: "Friendly"),
        Personality(value: "Helpful"),
        Personality(value: "Creative"),
        Personality(value: "Enthusiastic"),
        Personality(value: "Reliable"),
        Personality(value: "Patient"),
        Personality(value: "Responsible"),
        Personality(value: "Adaptable"),
        Personality(value: "Honest"),
        Personality(value: "Cheerful"),
        Personality(value: "Confident"),
        Personality(value: "Determined"),
        Personality(value: "Courageous"),
        Personality(value: "Generous"),
        Personality(value: "Loyal"),
        Personality(value: "Tolerant"),
        Personality(value: "Versatile"),
        Personality(value: "Ambitious"),
        Personality(value: "Curious"),
        Personality(value: "Logical")
    ]
    
    @State private var isKeyboardVisible: Bool = false
    
    
    private func isFormValid() -> Bool {
        return !dogName.isEmpty &&
        birthdayDate != nil &&
        gender >= 0 && gender < genderChoice.count &&
        !weight.isEmpty &&
        !selectedPersonalities.isEmpty &&
        !dogLocation.isEmpty &&
        !mobPhoneNumber.isEmpty &&
        (  (selectedImages != nil) || (selectedImages1 != nil)  || (selectedImages2 != nil) )
    }
    
    var filteredResorts: [CPData] {
        if searchCountry.isEmpty {
            return counrties
        } else {
            return counrties.filter { $0.name.contains(searchCountry) }
        }
    }
    
    var foregroundColor: Color {
        if colorScheme == .dark {
            return Color(.white)
        } else {
            return Color(.black)
        }
    }
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color(.systemGray5)
        } else {
            return Color(.systemGray6)
        }
    }
    
    let counrties: [CPData] = Bundle.main.decode("CountryNumbers.json")
    
    func FormatDate(birthdayDate:Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/DD/YYYY"
        return formatter.string(from: birthdayDate)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                ScrollView{
                    // Name
                    HStack{
                        Text("Name")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    //                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    TextField("Enter your dog's name", text: $dogName)
                        .multilineTextAlignment(.leading)
                        .padding(.leading)
                        .frame(minWidth: 80, minHeight: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.secondary, lineWidth: 1)
                        )
                        .padding(.horizontal,1)
                    //                                    .border(Color.black)
                    
                    
                    
                    // Birthday
                    HStack {
                        Text("Birthday")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    DatePickerTextField(placeholder: "MM/DD/YYYY", date: self.$birthdayDate)
                        .padding(.leading)
                        .frame(minWidth: 80, minHeight: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.secondary, lineWidth: 1)
                        )
                        .padding(.horizontal,1)
                    HStack{
                        Text("Gender")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        CustomSegmentedPicker(selection: $gender, items: genderChoice)
                        
                    }
                    .padding(.vertical)
                    
                    // Weight
                    HStack{
                        Text("Weight")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    HStack{
                        TextField("Enter your dog's weight", text: $weight)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                            .keyboardType(.decimalPad)
                            .onReceive(Just(weight)) { newValue in
                                            validateWeightInput(newValue: newValue)
                                        }
                        
                        //                        Divider()
                        //                                       .frame(height: 30)
                        Rectangle()
                            .fill(Color(hex: "3C3C43"))
                            .frame(width: 1)
                            .padding(.vertical, 10)
                            .padding(.horizontal,0)
                        
                        Text("kg")
                            .bold()
                            .padding(.horizontal)
                    }
                    .frame(minWidth: 80, minHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.clear)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(Color.secondary, lineWidth: 1)
                    )
                    .padding(.horizontal,1)
                    
                    // Personality
                    HStack {
                        Text("Personality")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    
                    .padding(.vertical, 5)
                    
                    VStack {
                        ZStack{
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 5) {
                                    ForEach(selectedPersonalities, id: \.self) { personality in
                                        HStack {
                                            Text(personality)
                                                .padding(.leading, 10)
                                                .padding(.vertical, 5)
                                            
                                            Button(action: {
                                                selectedPersonalities.removeAll { $0 == personality }
                                            }) {
                                                Image(systemName: "xmark.circle")
                                                    .foregroundColor(.black)
                                                    .padding(.vertical, 5)
                                                    .padding(.trailing, 5)
                                            }
                                        }
                                        .background(Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .cornerRadius(20)
                                        .fixedSize()
                                        .padding(.vertical, 2)
                                    }
                                    
                                    Button(action: {
                                        isShowingPersonalityList = true
                                    }) {
                                        Text("Add")
                                            .padding(.leading, 10)
                                            .padding(.vertical, 5)
                                        Image(systemName: "plus")
                                            .foregroundColor(.black)
                                            .padding(.vertical, 5)
                                            .padding(.trailing, 5)
                                    }
                                    .background(Color.gray.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(20)
                                    .fixedSize()
                                    .padding(.vertical, 2)
                                }
                            }
                            .padding(.horizontal, 10)
                            HStack {
                                TextField(selectedPersonalities.isEmpty ? "" : "", text: $kosong)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                                    .keyboardType(.decimalPad)
                                    .disabled(true) // Nonaktifkan TextField agar tidak bisa diubah
                            }
                            
                            
                        }
                        .frame(minWidth: 80, minHeight: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.secondary, lineWidth: 1)
                        )
                        .padding(.horizontal,1)
                    }
                    
                    
                    // Location
                    HStack {
                        Text("Location")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    .padding(.vertical, 5)
                    
                    VStack {
                        ZStack{
                            ScrollView(.horizontal, showsIndicators: false){
                                
                            }.onTapGesture {
                                // Ketika bagian Personality di-tap, tampilkan modal
                                isShowingLocationModal = true
                            }
                            HStack {
                                TextField("Enter your dog’s location" , text: dogLocation.isEmpty ? $city : $dogLocation)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading)
                                    .keyboardType(.decimalPad)
                                    .disabled(true) // Nonaktifkan TextField agar tidak bisa diubah
                            }
                            .onTapGesture {
                                // Ketika bagian Personality di-tap, tampilkan modal
                                isShowingLocationModal = true
                            }
                            
                        }
                        .onTapGesture {
                            // Ketika bagian Personality di-tap, tampilkan modal
                            isShowingLocationModal = true
                        }
                        
                        .frame(minWidth: 80, minHeight: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.clear)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(Color.secondary, lineWidth: 1)
                        )
                        .padding(.horizontal,1)
                    }
                    
                    
                    
                    // Phone Number
                    HStack {
                        Text("Phone Number")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            presentSheet = true
                            keyIsFocused = false
                        } label: {
                            Text("\(countryFlag) \(countryCode)")
                                .padding(10)
                                .foregroundColor(foregroundColor)
                                .frame(minWidth: 80, minHeight: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color.clear)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .stroke(Color.secondary, lineWidth: 1)
                                )
                                .padding(.horizontal,1)
                        }
                        
                        TextField("Phone number", text: $mobPhoneNumber)
                            .focused($keyIsFocused)
                            .keyboardType(.numberPad)
                            .onReceive(Just(mobPhoneNumber)) { _ in
                                applyPatternOnNumbers(&mobPhoneNumber, pattern: countryPattern, replacementCharacter: "#")
                            }
                            .padding(10)
                            .frame(minWidth: 80, minHeight: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color.clear)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color.secondary, lineWidth: 1)
                            )
                            .padding(.horizontal,1)
                    }
                    .padding(.bottom, 15)
                    
                    // Add Photos
                    HStack {
                        Text("Add Photos")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        if let image = selectedImages {
                            Button(action: {
                                imageKe = 0
                                self.isImagePickerPresented1.toggle()
                            }) {
                                AsyncImage(url: image){ result in
                                    result.image?
                                        .resizable()
                                        .scaledToFill()
                                }
                                    .centerCropped()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(16)
                            }
                            .padding()
                            .frame(width: 100, height: 100)
                            .cornerRadius(16)
                        }
                        
                        else {
                            Button(action: {self.isImagePickerPresented1.toggle()}) {
                                VStack {
                                    Image(systemName: "photo.badge.plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.teal)
                                }
                            }
                            .padding()
                            .frame(width: 100, height: 100)
                            //                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .foregroundColor(.teal)
                            )
                            .cornerRadius(16)
                        }
                        Spacer()
                        
                        if let image = selectedImages1 {
                            Button(action: {
                                imageKe = 1
                                self.isImagePickerPresented2.toggle()
                                
                            })
                            {
                                AsyncImage(url: image){ result in
                                    result.image?
                                        .resizable()
                                        .scaledToFill()
                                }
                                    .centerCropped()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(16)
                            }
                            .padding()
                            .frame(width: 100, height: 100)
                            .cornerRadius(16)
                        }
                        
                        else {
                            Button(action: {self.isImagePickerPresented2.toggle()}) {
                                VStack {
                                    Image(systemName: "photo.badge.plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.teal)
                                }
                            }
                            .padding()
                            .frame(width: 100, height: 100)
                            //
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .foregroundColor(.teal)
                            )
                            .cornerRadius(16)
                        }
                        Spacer()
                        
                        if let image = selectedImages2 {
                            Button(action: {
                                imageKe = 2
                                self.isImagePickerPresented3.toggle()
                                print(isFormValid())
                                print("selesai")
                                
                            }) {
                                AsyncImage(url: image){ result in
                                    result.image?
                                        .resizable()
                                        .scaledToFill()
                                }
                                    .centerCropped()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(16)

                            }
                            .padding()
                            .frame(width: 100, height: 100)
                            .cornerRadius(16)
                        }
                        
                        else {
                            Button(action: {self.isImagePickerPresented3.toggle()
                                print(isFormValid())
                                print("selesai")}) {
                                    VStack {
                                        Image(systemName: "photo.badge.plus")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.teal)
                                    }
                                }
                                .padding()
                                .frame(width: 100, height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                        .foregroundColor(.teal)
                                )
                                .cornerRadius(16)
                        }
                        Spacer()
                    }
                }
                
                VStack{
                    Button(action: {
                        // ACTION
                        print(dogViewModel.dogs.medicalRecord)
                        dogViewModel.dogs.name = dogName
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let formattedDate = dateFormatter.string(from: birthdayDate!)
                        dogViewModel.dogs.birthday = formattedDate
                        dogViewModel.dogs.gender = genderChoice[gender]
                        dogViewModel.dogs.weight = Float(weight)!
                        dogViewModel.dogs.personality = convertToPersonalityArray(from: selectedPersonalities)
                        func convertToPersonalityArray(from strings: [String]) -> [Personality] {
                            return strings.map { Personality(value: $0) }
                        }
                        dogViewModel.dogs.contact = phoneNumber
                        dogViewModel.dogs.location = dogLocation
                        dogViewModel.dogs.breed = dogBreed
                        isImageUploading = true
                        if let url = selectedImages{
                            dogViewModel.uploadFile(fileUrl: url, imageName: .profilePicture)
                        }
                        if let url = selectedImages1{
                            dogViewModel.uploadFile(fileUrl: url, imageName: .picture1)
                        }
                        if let url = selectedImages2{
                            dogViewModel.uploadFile(fileUrl: url, imageName: .picture2)
                        }
                        print(dogViewModel.dogs)
                    }) {
                        Text("Create Profile") .font(.system(size: 17)).fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(isFormValid() ? Colors.tosca : Color(hex: "#D9D9D9"))
                            .cornerRadius(30)
                            .foregroundColor(.white)
                    }.disabled(!isFormValid())

                }
               
//                .opacity(isKeyboardVisible ? 0 : 1) // Hide VStack when keyboard is visible
               
            }
            .padding(18)
            .navigationBarTitle("Dog's Informations", displayMode: .inline)
        }
//        .ignoresSafeArea(.keyboard)
//        .onTapGesture {
//                        UIApplication.shared.endEditing()
//                    }
    
//                .onAppear {
//                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
//                        withAnimation {
//                            isKeyboardVisible = true
//                        }
//                    }
//                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
//                        withAnimation {
//                            isKeyboardVisible = false
//                        }
//                    }
//                }
//                .onDisappear {
//                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//                    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//                }
        
        .sheet(isPresented: $isShowingPersonalityList, content: {
            PersonalityListView(selectedPersonalities: $selectedPersonalities)
        })
        .sheet(isPresented: $presentSheet) {
            NavigationView {
                List(filteredResorts) { country in
                    HStack {
                        Text(country.flag)
                        Text(country.name)
                            .font(.headline)
                        Spacer()
                        Text(country.dial_code)
                            .foregroundColor(.secondary)
                    }
                    .onTapGesture {
                        self.countryFlag = country.flag
                        self.countryCode = country.dial_code
                        self.countryPattern = country.pattern
                        self.countryLimit = country.limit
                        presentSheet = false
                        searchCountry = ""
                    }
                }
                .listStyle(.plain)
                .searchable(text: $searchCountry, prompt: "Your country")
            }
            .presentationDetents([.medium, .large])
        }
        .overlay(content: {
            if isImageUploading{
                ZStack {
                    Color(white: 0, opacity: 0.75)
                    ProgressView().tint(.white)
                }.ignoresSafeArea()
                if let upload =  dogViewModel.uploadStatus {
                    Text(upload).hidden()
                        .onAppear{
                            dogViewModel.addDog(newDog: dogViewModel.dogs)
                            isNavigationActive = true
                        }
                }
            }
        }) 
        .sheet(isPresented: $isImagePickerPresented1) {
            ImagePicker(selectedImage: $selectedImages)
        }
        .sheet(isPresented: $isImagePickerPresented2) {
            ImagePicker(selectedImage: $selectedImages1 )
        }
        .sheet(isPresented: $isImagePickerPresented3) {
            ImagePicker(selectedImage:  $selectedImages2 )
        }
        .sheet(isPresented: $isShowingLocationModal) {
            SearchView( isShowingLocationModal: $isShowingLocationModal, isShowingLocationModa2: $isShowingLocationModa2, dogLocation: $dogLocation, dogCoordinate: $dogCoordinate)
        }.onAppear{
            requestPhotoLibraryPermission()
        }
        .navigationDestination(
            isPresented: $isNavigationActive) {
                MedicalUploadDocumentView(dog: dogViewModel.dogs).environmentObject(DogViewModel())
                Text("Continue?")
                    .hidden()
            }
            .onAppear{
                requestPhotoLibraryPermission()
            }
    }
    
    func requestPhotoLibraryPermission() {
      PHPhotoLibrary.requestAuthorization { status in
        switch status {
        case .authorized:
          // Permission granted, proceed with image picker
            print("Authorized")
        case .denied, .restricted:
          // Permission denied or restricted, handle error
          print("Photos access denied")
        case .notDetermined:
          // Not yet decided, do nothing or prompt again later
          break
        case .limited:
            break
        @unknown default:
            break
        }
      }
    }
    
    func applyPatternOnNumbers(_ stringvar: inout String, pattern: String, replacementCharacter: Character) {
        var pureNumber = stringvar.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else {
                stringvar = pureNumber
                return
            }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
            
        }
        stringvar = pureNumber
    }
    
    private func validateWeightInput(newValue: String) {
            var filtered = newValue.filter { "0123456789,.".contains($0) }
            let decimalSeparators = [",", "."]
            let decimalCount = filtered.filter { decimalSeparators.contains(String($0)) }.count

            // If there are more than one decimal separator, remove the excess ones
            if decimalCount > 1 {
                var separatorFound = false
                filtered = filtered.filter {
                    if decimalSeparators.contains(String($0)) {
                        if separatorFound {
                            return false
                        } else {
                            separatorFound = true
                            return true
                        }
                    }
                    return true
                }
            }

            // Update the weight only if the filtered value is different from the newValue
            if filtered != newValue {
                weight = filtered
            }
        }
    
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class NumbersOnly: ObservableObject {
    @Published var value: Float = 0 {
        didSet {
            if value < 0 {
                value = 0
            }
        }
    }
    
    @Published var stringValue: String = ""
}

struct ModalView: View {
    @Binding var searchText: String
    @Binding var selectedOption: String?
    let options = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Siberian Husky", "Pomeranian", "Australian Shepherd", "Chihuahua"]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText).padding(.horizontal)
                
                List(options.filter {
                    self.searchText.isEmpty || $0.localizedCaseInsensitiveContains(self.searchText)
                }, id: \.self) { option in
                    Button(action: {
                        self.selectedOption = option
                        self.dismiss()
                    }) {
                        Text(option)
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle("Select Option", displayMode: .inline)
            .navigationBarItems(
                trailing: Button("Done") {
                self.dismiss()
            }
            )
        }
        
    }
    
    private func dismiss() {
        self.selectedOption = nil
        self.searchText = ""
    }


}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 24)
            Button(action: {
                self.text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
        }
        .padding(.vertical, 8)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(8)
    }
}


