//
//  PrimaryButtonStyle.swift
//  Home
//
//  Created by Perso on 26/02/2023.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		PrimaryButtonView(configuration: configuration)
	}

	struct PrimaryButtonView: View {
		@Environment(\.isEnabled) var isEnabled
			
		let configuration: PrimaryButtonStyle.Configuration
		
		var body: some View {
			return configuration.label
				.font(.title2.bold())
				.padding(4)
				.frame(height: 60)
				.frame(maxWidth: .infinity)
				.if({isEnabled}()) {
					$0.background(.linearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
				}
				.if({!isEnabled}()) {
					$0.background(.gray.opacity(0.2))
				}
				.mask(RoundedRectangle(cornerRadius: 16, style: .continuous ))
				.shadow(radius: 10)
				.scaleEffect(configuration.isPressed ? 0.9 : 1)
				.animation(.spring(response: 0.4, dampingFraction: 0.6), value: configuration.isPressed)
				.foregroundColor(isEnabled ? .white : .primary)
		}
	}
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			Button(action: {}) {
				Text("Normal")
			}
			.buttonStyle(PrimaryButtonStyle())
			
			Button(action: {}) {
				Text("Disabled")
			}
			.buttonStyle(PrimaryButtonStyle())
			.disabled(true)
		}
		.padding()
    }
}
