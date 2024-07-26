//
//  OnBoardingView.swift
//  MC3
//
//  Created by Alvito Dwi Reza on 23/07/24.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Spacer()
                Image("OnBoardingImage")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50.0)
                Spacer()
                Spacer()
                Spacer()
                Text("Finding a Mate")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Connects your dog with potential breeding partner")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                Spacer()
                Spacer()
                Spacer()
                NavigationLink(
                    destination: SelectBreedView()
                        .navigationBarBackButtonHidden(true),
                    label: {
                        Text("Next")
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
    OnBoardingView()
}
