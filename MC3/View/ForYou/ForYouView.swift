//
//  ForYouView.swift
//  MC3
//
//  Created by Daud on 14/07/24.
//

import SwiftUI

struct ForYouView: View {
    @EnvironmentObject var dogViewModel: DogViewModel
    var body: some View {
        NavigationStack {
            ForYouSwipe()
            .navigationBarTitle("For You", displayMode: .inline)
        }
    }
}

#Preview {
    ForYouView().environmentObject(DogViewModel())
}
