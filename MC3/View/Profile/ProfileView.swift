//
//  ProfileView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

let pageStates: [String] = ["About", "Medical"]

struct AboutView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("About").font(.system(size: 24, weight: .semibold, design: .default))
            Text("Meet Puppy, a charming Golden Retriever with a penchant for lounging and an insatiable desire to find love. With his fluffy coat and soulful eyes, Puppy may prefer naps over fetch, but his heart is as golden as his fur. Despite his relaxed demeanor, he dreams of finding a mate to share cuddles and lazy days with. Puppy's loyalty and gentle nature make him a delightful companion, always ready to brighten your days with his affectionate personality.").foregroundColor(.gray)
            HStack() {
                VStack(spacing: 8) {
                    Text("BREED").font(.system(size: 16)).foregroundStyle(.gray)
                    Text("Retriever").font(.system(size: 20, weight: .semibold))
                }
                Spacer()
                Rectangle().fill(Color.gray).frame(width: 1, height: 64)
                Spacer()
                VStack(spacing: 8) {
                    Text("AGE").font(.system(size: 16)).foregroundStyle(.gray)
                    Text("31 mo").font(.system(size: 20, weight: .semibold))
                }
                Spacer()
                Rectangle().fill(Color.gray).frame(width: 1, height: 64)
                Spacer()
                VStack(spacing: 8) {
                    Text("WEIGHT").font(.system(size: 16)).foregroundStyle(.gray)
                    Text("45 lbs").font(.system(size: 20, weight: .semibold))
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
            .background(.yellow)
            .cornerRadius(20)
        }
    }
}

struct MedicalView: View {
    var body: some View {
        List {
            NavigationLink(destination: MedicalDocumentView()) {
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.teal)
                    VStack(alignment: .leading, content: {
                        Text("Vaccination").font(.headline)
                        Text("See Vaccination Document").font(.system(size: 12))
                    })
                }
            }.padding(.vertical, 8)
            NavigationLink(destination: MedicalDocumentView()) {
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.teal)
                    VStack(alignment: .leading, content: {
                        Text("Medical Record").font(.headline)
                        Text("See Medical Record").font(.system(size: 12))
                    })
                }
            }.padding(.vertical, 8)
            NavigationLink(destination: MedicalDocumentView()) {
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.teal)
                    VStack(alignment: .leading, content: {
                        Text("Stamboom").font(.headline)
                        Text("See Stamboom Document").font(.system(size: 12))
                    })
                }
            }.padding(.vertical, 8)
        }
    }
}

struct ProfileView: View {
    @State private var pageState: String = "About"
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                // PROFILE IMAGE
                HStack(alignment: .firstTextBaseline) {
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                    VStack(alignment: .leading) {
                        Text("Dog's Name").font(.title)
                        Text("Location")
                        Button(action: {
                            // ACTION
                        }) {
                            HStack {
                                Image(systemName: "location.fill")
                                Text("See Dog Location")
                            }
                            .padding(10)
                            .background(Color.teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                        }
                    }
                }
                
                // SEGMENTED CONTROLS
                Picker("Filter", selection: $pageState) {
                    ForEach(pageStates, id: \.self) { tag in
                        Text(tag).tag(tag)
                    }
                }
                .pickerStyle(.segmented)
                
                // PAGE CONTENT
                if pageState == "About" {
                    AboutView()
                } else {
                    MedicalView()
                }
                
                Spacer()
            }
            .padding(24)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
}

#Preview {
    ProfileView()
}
