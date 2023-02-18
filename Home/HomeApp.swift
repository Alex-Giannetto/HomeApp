//
//  HomeApp.swift
//  Home
//
//  Created by Ålex on 18/02/2023.
//

import SwiftUI
import Firebase

@main
struct HomeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
