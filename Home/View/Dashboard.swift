//
//  Dashboard.swift
//  Home
//
//  Created by Perso on 06/03/2023.
//

import SwiftUI

struct Dashboard: View {
	@AppStorage(storageUser.uuid.rawValue) var userUID: String = ""
	
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
