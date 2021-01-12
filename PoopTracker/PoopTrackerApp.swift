//
//  PoopTrackerApp.swift
//  PoopTracker
//
//  Created by Sam Lubrano on 03/07/2020.
//

import SwiftUI
import Firebase
import Resolver

class AppDelegate: NSObject, UIApplicationDelegate {
    
    @Injected var authenticationService: AuthenticationService
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        authenticationService.signIn()
        return true
    }
}

@main
struct PoopTrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
