//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct TaskManagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authManager = FirebaseAuthManager()

    var body: some Scene {
        WindowGroup {
            if authManager.isSignedIn {
                ContentView()
                    .environmentObject(authManager)
            } else {
                SignInView()
                    .environmentObject(authManager)
            }
        }
    }
}
