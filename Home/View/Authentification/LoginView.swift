//
//  LoginView.swift
//  Home
//
//  Created by Perso on 22/02/2023.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct LoginView: View {
	@Binding public var isLoading: Bool
	
	@State private var email: String = ""
	@State private var password: String = ""
	
	@AppStorage(storageUser.uuid.rawValue) var userUID: String = ""
	@AppStorage(storageUser.email.rawValue) private var userEmail: String = ""
	@AppStorage(storageUser.firstname.rawValue) private var userFirstName: String = ""

	
	var body: some View {
		ZStack {
			Color.gray
				.opacity(0.1)
				.ignoresSafeArea()
			
			
			VStack {				
				InputComponent(icon: "at") {
					TextField("login_email_field", text: $email)
				}
				.padding(.bottom)

				InputComponent(icon: "lock") {
					SecureField("login_password_field", text: $password)
				}
			
				Spacer()
				
				Button(action: submit ) {
					Text("login_action_login")
				}
				.buttonStyle(PrimaryButtonStyle())
				.disabled(!formIsValid() || isLoading)

			}
			.padding()
			.padding([.top, .horizontal])
		}
		.modifier(LoadingModifier(isLoading: isLoading))
	}
	
	private func formIsValid() -> Bool {
		return !email.isEmpty
		&& email.isValidEmail()
		&& !password.isEmpty
	}
	
	private func submit() -> Void {
		closeKeyboard()
		withAnimation {
			isLoading = true
		}
		
		var _ = Auth.auth().signIn(withEmail: email, password: password)
	}
	
	func fetchUser() async throws {
		guard let userID = Auth.auth().currentUser?.uid else {return}
		let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
			
		await MainActor.run(body: {
			userUID = userID
			userEmail = user.email
			userFirstName = user.firstname
		})
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView(isLoading: .constant(false))
			.previewLayout(.sizeThatFits)
	}
}

