//
//  MC3App.swift
//  MC3
//
//  Created by Daud on 12/07/24.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAppCheck

class DogMitchCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    return AppAttestProvider(app: app)
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
      let providerFactory = DogMitchCheckProviderFactory()
      AppCheck.setAppCheckProviderFactory(providerFactory)
      
      FirebaseApp.configure()
      
      return true
  }
}

@main
struct MC3App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            OnBoardingView()
        }
    }
}
