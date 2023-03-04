//
//  CustomInput.swift
//  Home
//
//  Created by Perso on 23/02/2023.
//

import SwiftUI

struct InputValidator {
	var message: String
	var regex: Regex<Any>
}

struct InputComponent<Content: View>: View {
	var icon: String
	var field: Content
	var validators: [InputValidator] = []
	
	
	enum FocusedField {
		case field
	}
	@FocusState private var focusedField: FocusedField?
	
	init(icon: String, validators: [InputValidator], @ViewBuilder field: () -> Content) {
		self.init(icon: icon, field: field)
		self.validators = validators
	}
	
	init(icon: String, @ViewBuilder field: () -> Content) {
		self.field = field()
		self.icon = icon
	}
	
	var body: some View {
		HStack(spacing: 0) {
			Image(systemName: icon)
				.padding()
				.foregroundColor(.white)
			
			field
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

struct InputComponent_Previews: PreviewProvider {
	static var previews: some View {
		InputComponent(icon: "star", validators: [InputValidator(message: "message", regex: Regex(/(\w+)\s+(\d+)/))]) {
			TextField("demo", text: .constant(""))
		}
		.padding()
		.previewLayout(.sizeThatFits)
	}
}
