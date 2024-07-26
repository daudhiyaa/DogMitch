//
//  ForYouCard.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI


struct ForYouCard: View {
    let dog: Dog
    @State var isLiked: Bool = false
    
    var body: some View {
        VStack {
            Spacer() // Mendorong konten ke tengah vertikal
            GeometryReader { proxy in
                VStack() {
                    AsyncImage(url: URL(string: dog.profilePicture)) { image in
                        image.resizable()
                            .scaledToFill()
                    }placeholder: {
                        ProgressView()
                    }
                    
                    .centerCropped()
                    .frame(maxHeight: UIScreen.main.bounds.height * 0.3)
                    //                    .frame(height: 320)
                    .cornerRadius(30)
                    .padding(20)
                    Text(dog.name)
                    //                        .font(.system(size: 36))
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                    Text(dog.breed)
                    //                        .font(.system(size: 24))
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .fontWeight(.regular)
                    Text(dog.birthday)
                    //                        .font(.system(size: 17))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .fontWeight(.regular)
                        .padding(.bottom, 50)
                }
                .background(Colors.yellow)
                .cornerRadius(50)
                .overlay(alignment: .topLeading) {
                    VStack {
                        Image(dog.gender)
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                            .frame(width: 50, height: 50)
                    }
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(15)
                    .shadow(radius: 5)
                }
                .padding(0)
            }
            Spacer() 
        }
        
        .frame(maxWidth: UIScreen.main.bounds.width * 0.8, maxHeight: UIScreen.main.bounds.height * 0.5)
//        .background(Color.red)
        
    }
}

#Preview {
    ForYouCard(dog: Dog.sampleDogList[0])
}

extension AsyncImage {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
        }
    }
}




