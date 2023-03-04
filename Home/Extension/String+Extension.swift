//
//  String+Extension.swift
//  Home
//
//  Created by Perso on 23/02/2023.
//

import Foundation

extension String {
	/**
	 So that when you return a String it also adjusts the language
	 - Parameter comment: To describe specific meaning if it's unclear (e.g.: bear could mean the animal or the verb to bear)
	 - Returns: The localized String duh
	 - Usage: str.localize()
	 - Further reading: https://www.hackingwithswift.com/example-code/uikit/how-to-localize-your-ios-app
	 */
	func localize(comment: String = "") -> String {
		NSLocalizedString(self, comment: comment)
	}
	
	
	func isValidEmail() -> Bool {
		let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
		let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
		let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
		let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
		
		return emailPredicate.evaluate(with: self)
	}
	
	func isValidPassword() -> Bool {
		let passwordRules = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
		let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRules)
		
		return passwordPredicate.evaluate(with: self)
	}
}
