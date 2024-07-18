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
                        AsyncImage(url: URL(string: documentImage)){ result in
                            result.image?
                                .resizable()
                                .scaledToFit()
                        }
                        .centerCropped()
                        .frame(width: geometry.size.width, height: geometry.size.width * 1.5)
                        .cornerRadius(10)
                    }
                    
                    Button (action: {
                        // 
                    }, label: {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 16, height: 16)
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
    MedicalDocumentView(
        pageTitle: "Dummy Title",
        documentImage: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThJb3Aueh4k2-eOO3DgTZMUAFjtyvwArQChA&s"
    )
}
