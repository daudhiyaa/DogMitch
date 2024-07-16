//
//  AboutView.swift
//  MC3
//
//  Created by Daud on 16/07/24.
//

import SwiftUI

struct AboutView: View {
    let personalities: [Personality] = [
        Personality(value: "Friendly"),
        Personality(value: "Energetic"),
        Personality(value: "Loyal"),
        Personality(value: "Protective"),
        Personality(value: "Playful"),
        Personality(value: "Intelligent"),
        Personality(value: "Affectionate"),
        Personality(value: "Curious"),
        Personality(value: "Gentle"),
        Personality(value: "Independent"),
        Personality(value: "Alert"),
        Personality(value: "Sociable"),
        Personality(value: "Brave"),
        Personality(value: "Calm"),
        Personality(value: "Cheerful"),
        Personality(value: "Confident"),
        Personality(value: "Obedient"),
        Personality(value: "Quiet"),
        Personality(value: "Stubborn"),
        Personality(value: "Mischievous"),
        Personality(value: "Stubborn"),
        Personality(value: "Mischievous")
    ]
    
    let dogDetails: [(title: String, value: String)] = [
            ("BREED", "Retriever"),
            ("AGE", "31 mo"),
            ("WEIGHT", "45 lbs")
        ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Personality")
                    .font(.system(size: 24, weight: .semibold))
                
                FlowLayout(personalities) { tag in
                    Text(tag.value)
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                Spacer().frame(height: 16)
                HStack() {
                    ForEach(0..<dogDetails.count) { index in
                        VStack(spacing: 8) {
                            Text(dogDetails[index].title)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Text(dogDetails[index].value)
                                .font(.system(size: 20, weight: .semibold))
                        }
                        
                        if index < dogDetails.count - 1 {
                            Spacer()
                            Rectangle()
                                .fill(Color.gray)
                                .frame(width: 1, height: 64)
                            Spacer()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .padding(.horizontal, 28)
                .background(.yellow.opacity(0.5))
                .cornerRadius(20)
                Spacer().frame(height: 16)
                
                // GALLERY VIEW
                HStack(spacing: 16) {
                    GeometryReader { geometry in
                        Image("dog_profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.width
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    GeometryReader { geometry in
                        Image("dog_profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(
                                width: geometry.size.width,
                                height: geometry.size.width
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .frame(height: UIScreen.main.bounds.width / 2)
                }
            }
        }
    }
}

#Preview {
    AboutView()
}
