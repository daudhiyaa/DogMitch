//
//  LoadingView.swift
//  MC3
//
//  Created by Daud on 25/07/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(white: 0, opacity: 0.9)
            ProgressView().tint(.white)
        }.ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}
