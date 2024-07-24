//
//  VerificationDoneView.swift
//  MC3
//
//  Created by Alvito Dwi Reza on 23/07/24.
//

import SwiftUI

struct VerificationDoneView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Spacer()
                Image("VerificationDoneImage")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50.0)
                Spacer()
                Spacer()
                Spacer()
                Text("You have been verified!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Your buddy is ready to breed, Lets find a soulmate!")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                Spacer()
                Spacer()
                Spacer()
                NavigationLink(
                    destination: SelectBreedView(),
                    label: {
                        Text("Find soulmate!")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Colors.tosca)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                            .padding(18)
                    }
                )
            }
            .background(Circle()
                .fill(Color.yellow)
                .opacity(0.4)
                .frame(width: 700, height: 700)
                .offset(y: 400)
            )
        }
    }
}

#Preview {
    VerificationDoneView()
}
