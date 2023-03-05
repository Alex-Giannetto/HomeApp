//
//  View+Extension.swift
//  Home
//
//  Created by Perso on 23/02/2023.
//

import SwiftUI

extension View {
	
		// Closing all active keyboard
	func closeKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
	
		// MARK: Disabling with Opacity
	func disableWithOpacity(_ condition: Bool) -> some View {
		self
			.disabled(condition)
			.opacity(condition ? 0.6 : 1)
	}
	
	func hAlign(_ alignment: Alignment) -> some View {
		self
			.frame(maxWidth: .infinity, alignment: alignment)
	}
	
	func vAlign(_ alignment: Alignment) -> some View {
		self
			.frame(maxHeight: .infinity, alignment: alignment)
	}
	
		// MARK: Custom Border View With Padding
	func border(_ width: CGFloat, color: Color) -> some View {
		self
			.padding(.horizontal, 15)
			.padding(.vertical, 10)
			.background {
				RoundedRectangle(cornerRadius: 5, style: .continuous)
					.stroke(color, lineWidth: width)
			}
	}
	
		// MARK: Custom Fill View With Padding
	func fillView(_ color: Color) -> some View {
		self
			.padding(.horizontal, 15)
			.padding(.vertical, 10)
			.background {
				RoundedRectangle(cornerRadius: 5, style: .continuous)
					.fill(color)
			}
	}
	
	
	/// Applies the given transform if the given condition evaluates to `true`.
	/// - Parameters:
	///   - condition: The condition to evaluate.
	///   - transform: The transform to apply to the source `View`.
	/// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
	@ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
		if condition() {
			transform(self)
		} else {
			self
		}
	}
	
	
}
