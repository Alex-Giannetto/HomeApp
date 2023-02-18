//
//  ContentView.swift
//  Home
//
//  Created by Ålex on 18/02/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("home_usdz_path") var homeUSDZPath: String?
    
    var body: some View {
        VStack {
            if homeUSDZPath != nil {
                Text("You have your home already scanned")
            } else {
                RoomPlanView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.locale, Locale(identifier: "fr"))
            
            
            ContentView()
                .environment(\.locale, Locale(identifier: "en"))
        }
    }
}
