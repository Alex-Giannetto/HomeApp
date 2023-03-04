	//
	//  RegisterView.swift
	//  Home
	//
	//  Created by Perso on 24/02/2023.
	//

import SwiftUI

struct RegisterView: View {
	@Binding public var isLoading: Bool
	
	@State private var appear: Bool = false
	
	@State private var firstName: String = ""
	@State private var lastName: String = ""
	@State private var email: String = ""
	@State private var password: String = ""
	
	var body: some View {
		VStack {
			ScrollView {
				VStack {
					Group {
						InputComponent(icon: "person") {
							TextField("register_firstname_field", text: $firstName)
								.textContentType(.givenName)
						}
						.padding(.top)
						
						InputComponent(icon: "person") {
							TextField("register_lastname_field", text: $lastName)
								.textContentType(.familyName)
						}
						
						InputComponent(icon: "at") {
							TextField("register_email_field", text: $email)
								.keyboardType(.emailAddress)
								.textContentType(.emailAddress)
								.autocapitalization(.none)
								.disableAutocorrection(true)
						}
						
						InputComponent(icon: "lock") {
							SecureField("register_password_field", text: $password)
								.autocapitalization(.none)
								.disableAutocorrection(true)
						}
						
					}
					.padding(.bottom)
				}
			}
			
			Button(action: submit) {
				Text("register_action_register")
			}
			.buttonStyle(PrimaryButtonStyle())
			.disabled(!formIsValid())
		}
		.padding([.horizontal, .top])
		.background(.gray.opacity(0.1))
		.modifier(LoadingModifier(isLoading: isLoading))
		
	}
	
	private func formIsValid() -> Bool {
		return !firstName.isEmpty
		&& !lastName.isEmpty
		&& !email.isEmpty
		&& email.isValidEmail()
		&& !password.isEmpty
		&& password.isValidPassword()
	}
	
	private func submit() -> Void {
		closeKeyboard()
		withAnimation {
			isLoading = true
		}
	}
	
	
}

struct RegisterView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterView(isLoading: .constant(false))
	}
}
