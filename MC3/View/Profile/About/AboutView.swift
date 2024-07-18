//
//  AboutView.swift
//  MC3
//
//  Created by Daud on 16/07/24.
//

import SwiftUI

struct AboutView: View {
    var dog: Dog
    
    let rows = [GridItem(.flexible()), GridItem(.fixed(1)), GridItem(.flexible()), GridItem(.fixed(1)), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Personality")
                    .font(.system(size: 24, weight: .semibold))
                
                FlowLayout(dog.personality) { tag in
                    Text(tag.value)
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                
                // BREED, AGE, WEIGHT
                Spacer().frame(height: 16)
                GeometryReader { geometry in
                    HStack {
                        VStack(spacing: 8) {
                            Text("BREED")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Text(dog.breed)
                                .font(.system(size: 20, weight: .semibold))
                        }.frame(maxWidth: geometry.size.width / 3)
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1, height: 64)
                        
                        VStack(spacing: 8) {
                            Text("AGE")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Text(dog.birthday)
                                .font(.system(size: 20, weight: .semibold))
                        }.frame(maxWidth: geometry.size.width / 3)
                        
                        Rectangle()
                            .fill(Color.gray)
                            .frame(width: 1, height: 64)
                        
                        VStack(spacing: 8) {
                            Text("WEIGHT")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                            Text("\(String(dog.weight)) lbs")
                                .font(.system(size: 20, weight: .semibold))
                        }.frame(maxWidth: geometry.size.width / 3)
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 28)
                    .background(.yellow.opacity(0.5))
                    .cornerRadius(20)
                }
                Spacer().frame(height: 108)
                
                // GALLERY VIEW
                HStack(spacing: 16) {
                    GeometryReader { geometry in
                        AsyncImage(url: URL(string: dog.picture)){ result in
                            result.image?
                                .resizable()
                                .scaledToFill()
                        }
                        .centerCropped()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.width
                        )
                        .cornerRadius(10)
                    }
                    
                    GeometryReader { geometry in
                        AsyncImage(url: URL(string: dog.picture)){ result in
                            result.image?
                                .resizable()
                                .scaledToFill()
                        }
                        .centerCropped()
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.width
                        )
                        .cornerRadius(10)
                    }
                }.frame(height: UIScreen.main.bounds.width / 2)
            }
        }
    }
}

#Preview {
    AboutView(dog: Dog.sampleDogList[1])
}
