//
//  PersonalityListView.swift
//  MC3
//
//  Created by Jeffri Lieca H on 18/07/24.
//

import SwiftUI

struct PersonalityBadge: View {
    let personality: String
    let isSelected: Bool
    let onTap: () -> Void
    let onRemove: () -> Void
    
    var body: some View {
        HStack {
            Text(personality)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isSelected ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .fixedSize()
                .onTapGesture {
                    onTap()
                }
        }
    }
}

struct PersonalityListView: View {
    let personalities = [
        "Friendly", "Helpful", "Creative", "Enthusiastic", "Reliable",
        "Patient", "Responsible", "Adaptable", "Honest", "Cheerful",
        "Confident", "Determined", "Courageous", "Generous", "Loyal",
        "Tolerant", "Versatile", "Ambitious", "Curious", "Logical"
    ]
    
    @State private var text = ""
    @Binding  var selectedPersonalities: [String] 
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Selected Personalities")
                        .font(.headline)
                        .padding(.top)
                    Spacer()
                }
                .padding(.horizontal, 18)
                
                
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 80)
                    .overlay(
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
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
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .fixedSize()
                                    .padding(.vertical, 2)
                                }
                            }
                            .padding()
                        }
                    )
                    .padding(.bottom, 20)
                    .padding(.horizontal, 18)

                
                ScrollView {
                    VStack(alignment: .leading) {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 500))], spacing: 10) {
                            ForEach(filteredPersonalities, id: \.self) { personality in
                                PersonalityBadge(
                                    personality: personality,
                                    isSelected: selectedPersonalities.contains(personality),
                                    onTap: {
                                        if selectedPersonalities.contains(personality) {
                                            selectedPersonalities.removeAll { $0 == personality }
                                        } else if selectedPersonalities.count < 5 {
                                            selectedPersonalities.append(personality)
                                        }
                                    },
                                    onRemove: {
                                        selectedPersonalities.removeAll { $0 == personality }
                                    }
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .searchable(text: $text, prompt: "Search personalities")
            .navigationBarTitle("Personality List", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    var filteredPersonalities: [String] {
        if text.isEmpty {
            return personalities
        } else {
            return personalities.filter { $0.lowercased().contains(text.lowercased()) }
        }
    }
}
