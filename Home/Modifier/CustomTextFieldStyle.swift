//
//  CustomInput.swift
//  Home
//
//  Created by Perso on 23/02/2023.
//

import SwiftUI


struct CustomTextFieldStyle: TextFieldStyle {
	
	var icon: String?
	
	enum FocusedField {
		case field
	}
	@FocusState private var focusedField: FocusedField?
	
	func _body(configuration: TextField<Self._Label>) -> some View {
		HStack(spacing: 0) {
			if let secureIcon = icon {
				Image(systemName: secureIcon)
					.padding()
					.foregroundColor(.white)
			}
			
			configuration
				.focused($focusedField, equals: .field)
				.padding()
				.frame(height: 50)
				.background(.background.shadow(.inner(color: .black.opacity(focusedField == .field ? 0.5 : 0), radius: 4)), in: RoundedRectangle(cornerRadius: 8))
				.animation(.easeInOut, value: focusedField)
			
		}
		.frame(height: 50)
		.background(Color.accentColor)
		.overlay {
			RoundedRectangle(cornerRadius: 8)
				.strokeBorder(Color.accentColor, lineWidth: 2)
				.foregroundColor(Color.accentColor)
		}
		.clipShape(RoundedRectangle(cornerRadius: 8))
		.shadow(color: .black.opacity(focusedField == .field ? 0 : 0.2), radius: 4)
		.animation(.easeInOut, value: focusedField)
	}
}
