//
//  AuthentificationView.swift
//  Home
//
//  Created by Ålex on 18/02/2023.
//

import SwiftUI
import Firebase

struct AuthentificationView: View {
    @State private var animation: Bool = false
    @State private var showLoginSheet: Bool = false
	@State private var showRegisterSheet: Bool = false
	@State private var showRoomScannerSheet: Bool = false
	@State private var isLoading: Bool = false
	
	@AppStorage(storageUser.uuid.rawValue) var userUID: String = ""
	
    
    var body: some View {
        ZStack {
            AnimatedBlobComponent()
            
            VStack {
                Spacer()
                
                Text("authentification_title")
                    .font(.system(size: 50, weight: .black))
					.textAnimation(delay: 0.4)
					.padding(.bottom, 0.1)
				
                Text("authentification_description")
                    .font(.subheadline)
					.textAnimation(delay: 0.5)
                
                Spacer()
                Spacer()
				
				Button(action: {showLoginSheet.toggle()}) {
					Text("authentification_action_connect")
				}
				.buttonStyle(PrimaryButtonStyle())
				.frame(maxWidth: 250)
				.padding([.bottom, .horizontal])
				
				Button(action: {showRegisterSheet.toggle()}) {
                    Text("authentification_action_register")
                }
                .buttonStyle(.plain)
                .fontWeight(.bold)
                .foregroundColor(.secondary)

                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.regularMaterial)
            .onAppear { animation = true }
            .sheet(isPresented: $showLoginSheet) {
                LoginView(isLoading: $isLoading)
					.presentationDetents([.height(280)])
					.interactiveDismissDisabled(isLoading)
					.presentationDragIndicator(.visible)
            }
			.sheet(isPresented: $showRegisterSheet) {
				RegisterView(isLoading: $isLoading, showRoomScannerSheet: $showRoomScannerSheet)
					.presentationDetents([.height(400)])
					.interactiveDismissDisabled(isLoading)
					.presentationDragIndicator(.visible)
			}
			.onChange(of: userUID) { newValue in
				guard !newValue.isEmpty else { return }
				
			}
        }
    }
}

struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthentificationView()
    }
}
