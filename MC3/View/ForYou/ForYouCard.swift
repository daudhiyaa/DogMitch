//
//  ForYouCard.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI

struct ForYouCard: View {
    let dog: Dog
    @State var isLiked:Bool = false
    var body: some View {
        VStack {
            GeometryReader { proxy in
                VStack(spacing: 8) {
                    AsyncImage(url: URL(string: dog.profilePicture)){ result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .centerCropped()
                    .scaledToFill()
                    .frame(maxWidth: proxy.size.width, maxHeight: 320)
                    .clipped()
                    .cornerRadius(40)
                    .padding(20)
                    Text(dog.name).font(.system(size: 36)).foregroundColor(Color.white).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(dog.breed).font(.system(size: 24)).foregroundColor(Color.white).fontWeight(.regular)
                    Text(dog.birthday).font(.system(size: 17)).foregroundColor(Color.white).fontWeight(.regular).padding(.bottom,50)
                }.background(Colors.yellow)
                    .cornerRadius(40)
                    .overlay(alignment:.topLeading){
                        VStack{
                            Image(dog.gender)
                                .resizable()
                                .scaledToFit()
                                .padding(12)
                                .frame(width: 50, height: 50)
                        }.background(Color.white)
                            .cornerRadius(30)
                            .padding(15)
                            .shadow(radius: 5)
                    }
                    .overlay(alignment:.bottomTrailing){
                        Button{
                            isLiked.toggle()
                            //
                        }label:{
                            VStack{
                                if isLiked{
                                    Image(systemName:"heart.fill").resizable()
                                        .scaledToFit()
                                        .padding(12)
                                        .foregroundColor(Color.red)
                                        .frame(width: 50, height: 50)
                                }else{
                                    Image(systemName:"heart").resizable()
                                        .scaledToFit()
                                        .padding(12)
                                        .foregroundColor(Color.red)
                                        .frame(width: 50, height: 50)
                                }
                            }.background(Colors.lightpink.opacity(0.2))
                                .cornerRadius(30)
                                .padding(20)
                                .padding(.bottom,20)
                        }
                    }
            }
            .frame(width: 330, height: 500)
            .padding(.horizontal, 12)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top) {
            ForEach(Dog.sampleDogList) { order in
                ForYouCard( dog: order)
            } .listRowSeparator(.hidden)
        }
    }
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
