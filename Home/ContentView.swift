//
//  ContentView.swift
//  Home
//
//  Created by Ålex on 18/02/2023.
//

import SwiftUI

struct ContentView: View {
	@AppStorage(storageUser.uuid.rawValue) var userUID: String = ""
    
    var body: some View {
        VStack {
			if userUID.isEmpty {
				AuthentificationView()
            } else {
				Dashboard()
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
