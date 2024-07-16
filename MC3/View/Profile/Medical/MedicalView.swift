//
//  MedicalView.swift
//  MC3
//
//  Created by Daud on 16/07/24.
//

import SwiftUI

struct MenuItem {
    let iconName: String
    let title: String
}

let menuItems = [
    MenuItem(iconName: "medical_icon", title: "Vaccination"),
    MenuItem(iconName: "medical_icon", title: "Stamboom"),
    MenuItem(iconName: "medical_icon", title: "Medical Record")
]

struct MedicalView: View {
    var body: some View {
        List {
            Section{
                ForEach(menuItems, id: \.title) { item in
                    NavigationLink(destination: Text(item.title)) {
                        HStack {
                            Image(item.iconName)
                            VStack(alignment: .leading) {
                                Text(item.title).font(.headline)
                                Text("See \(item.title) Document")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                            }
                        }
                    }.padding(.vertical, 8)
                        // .listRowBackground(Color.gray.opacity(0.1))
                }
            }
        }.clipShape(RoundedRectangle(cornerRadius: 20)).listStyle(.plain)
    }
}

#Preview {
    MedicalView()
}
