//
//  ReminderPopUpView.swift
//  MC3
//
//  Created by Alvito Dwi Reza on 24/07/24.
//

import SwiftUI

struct ReminderPopUpView: View {
    @Binding var isActive: Bool

    let title: String
    let message: String
    let buttonTitle: String
    let action: () -> ()
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    close()
                }
            VStack {
                Image("BlankProfileImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                Text(title)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
                    .padding(.bottom, 3.0)
                    
                
                Text(message)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)

                Button {
                    action()
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(Colors.tosca)

                        Text(buttonTitle)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.black)
                .padding()
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}


#Preview {
    ReminderPopUpView(
        isActive: .constant(true),
        title: "Fill Your Dog's Information First",
        message: "To gain trust of other dog owners, please provide your dog's details and verify its health",
        buttonTitle: "Complete Now",
        action: {}
    )
}
