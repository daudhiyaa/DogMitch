//
//  MedicalDocumentView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct MedicalDocumentView: View {
    var pageTitle: String
    var documentImage: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                ZStack (alignment: .topTrailing) {
                    GeometryReader { geometry in
                        Image(documentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Button (action: {
                        // 
                    }, label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.teal)
                            .aspectRatio(contentMode: .fit)
                            .padding(8)
                            .background(.white)
                            .clipShape(Circle())
                            .offset(x: -10, y: 10)
                            .shadow(radius: 10)
                    })
                }
            }
            .padding(24)
            .navigationBarTitle(pageTitle, displayMode: .inline)
        }
    }
}

#Preview {
    MedicalDocumentView(pageTitle: "Dummy Title", documentImage: "dog_profile")
}
