//
//  AuthentificationView.swift
//  Home
//
//  Created by Ålex on 18/02/2023.
//

import SwiftUI
import Firebase

struct AuthentificationView: View {
    
    var body: some View {
        Image("authentification_background")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
    }
}

struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView()
    }
}
