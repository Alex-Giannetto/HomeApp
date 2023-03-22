	//
	//  RegisterView.swift
	//  Home
	//
	//  Created by Perso on 24/02/2023.
	//

import SwiftUI
import Firebase
import FirebaseFirestore

struct RegisterView: View {
	@Binding public var isLoading: Bool
	@Binding public var showRoomScannerSheet: Bool
	
	@Environment(\.dismiss) var dismiss
	
	@State private var appear: Bool = false
	
	@State private var firstName: String = ""
	@State private var lastName: String = ""
	@State private var email: String = ""
	@State private var password: String = ""
	
	@AppStorage(storageUser.uuid.rawValue) var userUID: String = ""
	@AppStorage(storageUser.email.rawValue) private var userEmail: String = ""
	@AppStorage(storageUser.firstname.rawValue) private var userFirstName: String = ""
	
	@State private var errorMessage: String = ""
	@State private var showError: Bool = false

	
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
			.padding(.bottom)
		}
		.padding([.horizontal, .top])
		.background(.gray.opacity(0.1))
		.modifier(LoadingModifier(isLoading: isLoading))
		.alert(errorMessage, isPresented: $showError) {
			Button("retry") {}
		}
		
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

		Task {
			do {
				// Step 1: Creating Firebase Account
				try await Auth.auth().createUser(withEmail: email, password: password)
				guard let userUID = Auth.auth().currentUser?.uid else {return}
				let user = User(firstname: firstName, lastname: lastName, email: email)
				let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user, completion: { error in
					self.userUID = userUID
					self.userFirstName = firstName
					self.userEmail = email
					self.isLoading = false
					dismiss()
				})
			} catch {
				print("Error during creating account : \(error)")
				errorMessage = error.localizedDescription
				showError = true
				isLoading = false
			}
		}
	}
}

struct RegisterView_Previews: PreviewProvider {
	static var previews: some View {
		RegisterView(isLoading: .constant(false), showRoomScannerSheet: .constant(false))
	}
}
