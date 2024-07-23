//
//  MedicalView.swift
//  MC3
//
//  Created by Daud on 16/07/24.
//

import SwiftUI

let menuItems: [String] = [
    "Vaccination",
    "Stamboom",
    "Medical Record"
]

struct MedicalView: View {
    var dog: Dog
    var isMyProfile: Bool = false
    
    var body: some View {
        List {
            ForEach(menuItems, id: \.self) { item in
                if isMyProfile {
                    NavigationLink(
                        destination: MedicalDocumentView(
                            pageTitle: item,
                            documentImage:
                                item == menuItems[0] ? dog.vaccine :
                                item == menuItems[1] ? dog.stamboom :
                                dog.medicalRecord
                        )
                    ) {
                        HStack {
                            Image("medical_icon")
                            VStack(alignment: .leading) {
                                Text(item).font(.headline)
                                Text("See \(item) Document")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }.padding(.vertical, 8)
                }
                else{
                    HStack(spacing: 16) {
                        Image("medical_icon")
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item).font(.headline)
                            Text("See \(item) Document")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.gray.opacity(0.3))
                    }
                }
            }
        }.clipShape(RoundedRectangle(cornerRadius: 20)).listStyle(.plain)
    }
}

#Preview {
    MedicalView(dog: Dog.sampleDogList[1])
}
