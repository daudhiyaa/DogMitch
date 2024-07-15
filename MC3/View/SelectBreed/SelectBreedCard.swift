//
//  SelectBreedCard.swift
//  MC3
//
//  Created by Marsha Likorawung on 15/07/24.
//

import SwiftUI

struct SelectBreedCard: View {
    let name: String
    var body: some View {
        ZStack(alignment: .topTrailing) { 
            RoundedRectangle(cornerRadius: 20)
                .fill(Colors.yellow)
                .frame(maxWidth: 170, maxHeight: 95)
            VStack{
                HStack{
                    Image(name)
                        .resizable()
                        .scaledToFit()
                        .offset(x: -10, y: -25)
                    Text(name).font(.system(size: 17)).foregroundColor(Color.white).fontWeight(.semibold)
                        .offset(x: -10, y: -15)
                }
            }
        }.frame(maxWidth: 170, maxHeight: 120)
    }
}

#Preview {
    SelectBreedCard(name: "Labrador Retriever")
}
