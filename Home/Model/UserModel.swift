//
//  UserModel.swift
//  Home
//
//  Created by Perso on 05/03/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
	@DocumentID var id: String?
	var firstname: String
	var lastname: String
	var email: String
	
	enum CodingKeys: CodingKey {
		case id
		case firstname
		case lastname
		case email
	}
}


enum storageUser: String {
	case uuid = "user_uuid"
	case email = "user_email"
	case firstname = "user_firstname"
}
