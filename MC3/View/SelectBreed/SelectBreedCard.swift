//
//  SelectBreedCard.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI

struct SelectBreedCard: View {
    let name: String
    let isChosen: Bool
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if isChosen{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Colors.gray)
                    .frame(maxWidth: 170, maxHeight: 95)
            }else{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Colors.yellow)
                    .frame(maxWidth: 170, maxHeight: 95)
            }
            VStack(alignment: .leading){
                HStack{
                    VStack{
                        if isChosen{
                            Image(name)
                                .resizable()
                                .renderingMode(.original)
                                .grayscale(1)
                                .scaledToFit()
                                .offset(x: -10, y: -25)
                        }else{
                            Image(name)
                                .resizable()
                                .scaledToFit()
                                .offset(x: -10, y: -25)
                        }
                    }
                    Text(name).font(.system(size: 17)).foregroundColor(Color.white).fontWeight(.semibold)
                        .offset(x: -10, y: -15)
                }
            }
        }.frame(maxWidth: 170, maxHeight: 120, alignment: .bottom)
    }
}

#Preview {
    SelectBreedCard(name: "German Shepherd", isChosen: true)
}

