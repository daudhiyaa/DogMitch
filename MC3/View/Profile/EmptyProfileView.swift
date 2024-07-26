//
//  BlankProfileView.swift
//  MC3
//
//  Created by Alvito Dwi Reza on 24/07/24.
//

import SwiftUI

struct EmptyProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("BlankProfileImage")
                    .padding()
                
                Text("Oops!\nYou Have Not Complete Your Dog's Profile")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                    .padding(.horizontal, 15.0)
                
                Text("To gain the trust of other dog owners, please provide your dog's details and verify its health.")
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 41.0)
                    .padding(.vertical, 6.0)
                
                // Button
                NavigationLink(
                    destination: SelectBreedView(),
                    label: {
                        Text("Complete Now")
                            .font(.system(size: 17))
                            .fontWeight(.semibold)
                            .frame(width: 200, height: 20)
                            .padding(12)
                            .background(Colors.tosca)
                            .cornerRadius(30)
                            .foregroundColor(.white)
                            .padding(18)
                    }
                )
            }
            .navigationTitle(Text("Profile"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    EmptyProfileView()
}
