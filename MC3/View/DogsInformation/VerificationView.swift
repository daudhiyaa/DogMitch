//
//  VerificationView.swift
//  MC3
//
//  Created by Zafira Salma Salsabil on 23/07/24.
//

import SwiftUI

struct VerificationView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Spacer()
                Spacer()
                Image("verification_image")
                    .resizable(capInsets: EdgeInsets())
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50.0)
                Spacer()
                Spacer()
                Spacer()
                Text("Your dog's health is currently under review. It will be verified within a maximum of 24 hours.")
                    .font(.body)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 50)
                Spacer()
                Spacer()
                Spacer()
                
                NavigationLink(
                    destination: EmptyView(),
                    label: {
                        Text("Ok")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color.mint)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                            .padding(18)
                    }
                )
            }
            .navigationBarTitle("Health Verification", displayMode: .inline)
        }
    }
}

#Preview {
    VerificationView()
}
