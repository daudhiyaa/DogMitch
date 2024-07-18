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

struct DogsInformationView: View {
    
    @State var dog: Dog?
    
    
    init(){
        UISegmentedControl.appearance().selectedSegmentTintColor = .white
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.blue], for: .selected)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().layer.cornerRadius = 20
        //        UISegmentedControl.appearance().
    }
    
//    @State private var searchText = ""
    @State private var dogName = ""
    @State private var birthdayDate : Date?
    @State private var birthdayText = ""
    @State private var isComplete = false
    @State private var showDatePicker = false
//    @State private var backgroundColor: Color = Color.black.opacity(0.05)
    @ObservedObject var weight = NumbersOnly()
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
    @State private var dogCoordinate : CLLocation = CLLocation()
    
    
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
    @State private var selectedImage: UIImage?
//        @State private var isImagePickerPresented = false
    @State private var isImagePickerPresented1 = false
    @State private var isImagePickerPresented2 = false
    @State private var isImagePickerPresented3 = false
    @State private var selectedImages: [UIImage?] = [
            UIImage(named: "image1"),
            UIImage(named: "image2"),
            UIImage(named: "image3")
        ]
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

    
    private func isFormValid() -> Bool {
        return !dogName.isEmpty &&
               birthdayDate != nil &&
               gender >= 0 && gender < genderChoice.count &&
                !(weight.value > 0) &&
               !selectedPersonalities.isEmpty &&
               !dogLocation.isEmpty &&
               !mobPhoneNumber.isEmpty &&
               (  (selectedImages[0] != nil) || (selectedImages[1] != nil)  || (selectedImages[2] != nil) )
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
                
                ScrollView(){
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
//                        .textFieldStyle(.roundedBorder)
//                        .background(RoundedRectangle(cornerRadius: 10))
//                        .border(RoundedRectangle(cornerRadius: 10))
//                        .padding(10)
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
                        TextField("Enter your dog's weight", text: $weight.stringValue)
                                .multilineTextAlignment(.leading)
                                .padding(.leading)
                                .keyboardType(.decimalPad)
                            
//                        Divider()
//                                       .frame(height: 30)
                        Rectangle()
                                                   .fill(Color(hex: "3C3C43"))
                                                   .frame(width: 1)
                                                   .padding(.vertical, 10)
                                                   .padding(.horizontal,0)
                                       
                            Text("kg")
//                                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                            .bold()
                            .padding(.horizontal)
//                            .border(Color.black)
//
                        
                        
                        
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
                                        .background(Color.gray)
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
                                    .background(Color.gray)
                                    .foregroundColor(.black)
                                    .cornerRadius(20)
                                    .fixedSize()
                                    .padding(.vertical, 2)
                                }
                                
                                //                                .padding()
                            }
                            .padding(.horizontal, 10)
//                            .frame(height: 60)
//
//                            .border(Color.black)
                           
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
//                        
//                        
//                        
//                        Rectangle()
//                            .fill(Color(hex: "3C3C43"))
//                            .frame(height: 1)
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
                                
                            }
//                            .frame(height: 60)
//
//                            .border(Color.black)
                            .onTapGesture {
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
                        .border(Color.white) // Tambahkan border
//                        .padding(.bottom, 5)
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
                    
//                    .padding(.vertical, 5)

//                    TextField("+X (XXX) XXX-XXXX", text: $phoneNumber)
//                                    .keyboardType(.numberPad)
//                                    .onChange(of: phoneNumber) { newValue in
////                                        let formattedPhoneNumber = format(with: "+X (XXX) XXX-XXXX", phone: newValue)
//                                        let formattedPhoneNumber = format(with: "XXXXXXXXXXXXXXX", phone: newValue)
//                                        if formattedPhoneNumber != newValue {
//                                            phoneNumber = formattedPhoneNumber
//                                        }
//                                    }
//                                    .padding(.leading)
////                                    .border(Color.gray)
                        
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
//                            .placeholder(when: mobPhoneNumber.isEmpty) {
//                                Text("Phone number")
//                                    .foregroundColor(.secondary)
//                            }
                            .focused($keyIsFocused)
                            .keyboardType(.numbersAndPunctuation)
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
//                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    
                    // Add Photos
                    HStack {
                        Text("Add Photos")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    HStack {
//                        HStack{
//                            if let image = selectedImage {
//                                Button(action: {self.isImagePickerPresented.toggle()}) {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .cornerRadius(16)
//                                        .frame(width: 80, height: 80)
//                                }
//                            }
//                            else {
//                                Button(action: {self.isImagePickerPresented.toggle()}) {
//                                    VStack {
//                                        Image(systemName: "photo.badge.plus")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 40, height: 40)
//                                            .foregroundColor(.teal)
//                                        //                                           Text("Upload Payment Receipt").foregroundColor(.teal)
//                                    }
//                                    //                                       .padding([.vertical, .horizontal], 20)
//                                    .frame(width: 80, height: 80)
//                                }
//                                .padding()
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 16)
//                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                                        .foregroundColor(.teal)
//                                )
//                                .cornerRadius(16)
//                            }
//                        }
//                        
//                        HStack{
//                            if let image = selectedImage {
//                                Button(action: {self.isImagePickerPresented.toggle()}) {
//                                    Image(uiImage: image)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .cornerRadius(16)
//                                        .frame(width: 80, height: 80)
//                                }
//                            }
//                            else {
//                                Button(action: {self.isImagePickerPresented.toggle()}) {
//                                    VStack {
//                                        Image(systemName: "photo.badge.plus")
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width: 40, height: 40)
//                                            .foregroundColor(.teal)
//                                        //                                           Text("Upload Payment Receipt").foregroundColor(.teal)
//                                    }
//                                    //                                       .padding([.vertical, .horizontal], 20)
//                                    .frame(width: 80, height: 80)
//                                }
//                                // Mengatur ukuran frame agar persegi
//                                //                                                  .padding()
//                                .padding()
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 16)
//                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                                        .foregroundColor(.teal)
//                                )
//                                .cornerRadius(16)
//                            }
//                        }
//                        
                        Spacer()
                        if let image = selectedImages[0] {
                            Button(action: {
                                imageKe = 0
                                self.isImagePickerPresented1.toggle()
                                }) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(16)
                                    .frame(width: 100, height: 100)
                            }
                                .padding()
                            .frame(width: 100, height: 100)
//                            .padding()
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 16)
//                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                                    .foregroundColor(.teal)
//                            )
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
                                    //                                           Text("Upload Payment Receipt").foregroundColor(.teal)
                                }
                                //                                       .padding([.vertical, .horizontal], 20)
                               
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
                        
                        if let image = selectedImages[1] {
                            Button(action: {
                                imageKe = 1
                                self.isImagePickerPresented2.toggle()
                                
                            })
                            {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(16)
                                    .frame(width: 100, height: 100)
                            }
                            .padding()
                            .frame(width: 100, height: 100)
//                            .padding()
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 16)
//                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                                    .foregroundColor(.teal)
//                            )
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
                                    //                                           Text("Upload Payment Receipt").foregroundColor(.teal)
                                }
                                //                                       .padding([.vertical, .horizontal], 20)
                               
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
                        
                        if let image = selectedImages[2] {
                            Button(action: {
                                imageKe = 2
                                self.isImagePickerPresented3.toggle()
                            print(isFormValid())
                                print("selesai")
                                if !isFormValid() {
                                    print("Form validation failed. Missing or invalid:")
                                    if dogName.isEmpty {
                                        print("- Dog Name")
                                    }
                                    if birthdayDate == nil {
                                        print("- Date")
                                    }
                                
                                    if !(gender >= 0 && gender < genderChoice.count) {
                                        print("- Gender")
                                    }
                                    if weight.value>0 {
                                        print("- Weight")
                                    }
                                    if selectedPersonalities.isEmpty {
                                        print("- Selected Personalities")
                                    }
                                    if dogLocation.isEmpty {
                                        print("- Dog Location")
                                    }
                                    if mobPhoneNumber.isEmpty {
                                        print("- Phone Number")
                                    }
                                    if selectedImages.count == 0 {
                                        print("- Selected Image")
                                    }
                                }

                                
                            }) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .cornerRadius(16)
                                    .frame(width: 100, height: 100)
                            }
                                .padding()
                            .frame(width: 100, height: 100)
//                            .padding()
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 16)
//                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                                    .foregroundColor(.teal)
//                            )
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
                                    //                                           Text("Upload Payment Receipt").foregroundColor(.teal)
                                }
                                //                                       .padding([.vertical, .horizontal], 20)
                               
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
                        
                        
                    }
                    
//                    Text("Personality")
//                                        .font(.system(size: 24, weight: .semibold))
//                                    
//                                    FlowLayout(personalities) { tag in
//                                        Text(tag.value)
//                                            .foregroundColor(.black)
//                                            .padding(.horizontal, 12)
//                                            .padding(.vertical, 6)
//                                            .background(.gray.opacity(0.1))
//                                            .clipShape(RoundedRectangle(cornerRadius: 20))
//                                    }
                   
    
                }
                
                
                VStack{
                    if isFormValid(){
                        Button(action: {
                            // ACTION
                            dog?.name = dogName
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let formattedDate = dateFormatter.string(from: birthdayDate!)
                            dog?.birthday = formattedDate
                            dog?.gender = genderChoice[gender]
                            dog?.weight = weight.value
                            dog?.personality = convertToPersonalityArray(from: selectedPersonalities)
                            func convertToPersonalityArray(from strings: [String]) -> [Personality] {
                                return strings.map { Personality(value: $0) }
                            }
                            dog?.location = dogLocation
                            
                        }) {
                            Text("Create Profile") .font(.system(size: 17)).fontWeight(.semibold)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding(12)
                                .background(Colors.tosca)
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }
                    }else{
                        Button(action: {
                            // ACTION
                        }) {
                            Text("Create Profile") .font(.system(size: 17)).fontWeight(.semibold)
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                                .padding(12)
                                .background(Color(hex: "#D9D9D9"))
                                .cornerRadius(30)
                                .foregroundColor(.white)
                        }.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    }
                    
                }
            }.padding(18)
                .navigationBarTitle("Dog's Informations", displayMode: .inline)
        }
        
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
        .sheet(isPresented: $isImagePickerPresented1) {
                    ImagePicker(selectedImage: self.$selectedImages[0] )
                }
        .sheet(isPresented: $isImagePickerPresented2) {
                    ImagePicker(selectedImage: self.$selectedImages[1] )
                }
        .sheet(isPresented: $isImagePickerPresented3) {
                    ImagePicker(selectedImage: self.$selectedImages[2] )
                }
        .sheet(isPresented: $isShowingLocationModal) {
            SearchView( isShowingLocationModal: $isShowingLocationModal, isShowingLocationModa2: $isShowingLocationModa2, dogLocation: $dogLocation, dogCoordinate: $dogCoordinate)
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
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    DogsInformationView()
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
    
//    init() {
//        _ = $value
//            .map { String($0) }
//            .assign(to: &$stringValue)
//    }
}

struct ModalView: View {
    @Binding var searchText: String
    @Binding var selectedOption: String?
    let options = ["Labrador Retriever", "German Shepherd", "Golden Retriever", "Bulldog", "Siberian Husky", "Pomeranian", "Australian Shepherd", "Chihuahua"]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                
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
            .navigationBarItems(trailing:
                Button("Done") {
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

