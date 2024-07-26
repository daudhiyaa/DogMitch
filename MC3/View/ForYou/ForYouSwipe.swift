//
//  SelectBreedSwipeView.swift
//  MC3
//
//  Created by Jeffri Lieca H on 24/07/24.
//

import SwiftUI

struct ForYouSwipe: View {
    @State var currentIndex: Int = 0
    @EnvironmentObject var dogViewModel: DogViewModel
    @State private var translation: CGSize = .zero
    @State private var isNavigationActive = false
    @State var isLiked:Bool = false
    @Binding var dogs : [Dog]


    var body: some View {
        NavigationStack {
            ZStack {
                ForEach(dogs.indices, id: \.self) { index in
                    if abs(index - currentIndex) <= 1 {
                        ForYouCard(dog: dogs[index])
                           
//                            .padding(.horizontal)
                           
//                            .padding(.horizontal)
//                            .background(Color.red.opacity(0.5))
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        self.translation = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if translation.width < -50 && currentIndex < dogs.count - 1 {
                                            currentIndex += 1
                                           
                                        }
                                        if translation.width > 50 && currentIndex > 0 {
                                            currentIndex -= 1
                                          
                                        }
                                        translation = .zero
                                    }
                            )
                            .simultaneousGesture(
                                TapGesture()
                                    .onEnded {
                                        if index == currentIndex{
                                            isNavigationActive = true
                                        }
                                        else {
                                            currentIndex = index
                                        }
                                        
                                    }
                            )
                            .offset(x: CGFloat(index - currentIndex) * UIScreen.main.bounds.width * 0.9 + translation.width, y: 0)
                            .scaleEffect(index == currentIndex ? 1 : 0.9)
                            .opacity(index == currentIndex ? 1 : 0.8)
                            .animation(.spring())
//                            .padding(.horizontal)
//                            .background(Color.red.opacity(0.5))
                           
                    }
                }
            }
            .navigationDestination(isPresented: $isNavigationActive) {
                ProfileView(dog: dogs[currentIndex]).environmentObject(DogViewModel())
            }
        }
    }
}

//#Preview {
//    ForYouSwipe()
//}


