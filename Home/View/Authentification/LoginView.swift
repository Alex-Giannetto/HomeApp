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
	
	@State private var showError: Bool = false
	@State private var errorMessage: String = ""
	
	@AppStorage(storageUser.uuid.rawValue) var userUID: String = ""
	@AppStorage(storageUser.email.rawValue) private var userEmail: String = ""
	@AppStorage(storageUser.firstname.rawValue) private var userFirstName: String = ""
	
	
	var body: some View {
		ZStack {
			Color.gray
				.opacity(0.1)
				.ignoresSafeArea()
			
			VStack {
				TextField("login_email_field", text: $email)
					.textFieldStyle(CustomTextFieldStyle(icon: "at"))
					.autocapitalization(.none)
					.disableAutocorrection(true)
					.padding(.bottom)
				
				SecureField("login_password_field", text: $password)
					.textFieldStyle(CustomTextFieldStyle(icon: "lock"))
				
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
		.alert(errorMessage, isPresented: $showError) {
			Button("close") {}
		}
	}
	
	private func formIsValid() -> Bool {
		let conditions  = [
			!email.isEmpty,
			email.isValidEmail(),
			!password.isEmpty
		]
		
		return conditions.allSatisfy { $0 }
	}
	
	private func submit() -> Void {
		closeKeyboard()
		withAnimation {
			isLoading = true
		}
		Task {
			do {
					// With the helo of Swift Concurrency Auth can be done with Single Line
				try await Auth.auth().signIn(withEmail: email, password: password)
				print("User Found")
				try await fetchUser()
				
			} catch {
				await setError(error)
			}
		}
		
		var _ = Auth.auth().signIn(withEmail: email, password: password)
	}
	
	func fetchUser() async throws {
		print("let's fetch user data")
		guard let userID = Auth.auth().currentUser?.uid else {return}
		print("userID : \(userID)")
		let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
		
		print(user)
		
		await MainActor.run(body: {
			userUID = userID
			userEmail = user.email
			userFirstName = user.firstname
		})
	}
	
	func loginUser() {
		isLoading = true
		closeKeyboard()
		Task {
			do {
				try await Auth.auth().signIn(withEmail: email, password: password)
				print("User Found")
				try await fetchUser()
				
			} catch {
				await setError(error)
			}
		}
	}
	
		// MARK Displaing Errors VIA Alert
	func setError(_ error: Error) async {
			// MARK: UI Must be Updated on Main Thread
		await MainActor.run(body: {
			errorMessage = error.localizedDescription
			showError.toggle()
			isLoading = false
		})
	}
	
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView(isLoading: .constant(false))
			.previewLayout(.sizeThatFits)
	}
}

