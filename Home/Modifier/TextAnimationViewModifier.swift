//
//  TitleAnimationViewModifier.swift
//  Home
//
//  Created by Perso on 24/02/2023.
//

import SwiftUI

struct TextAnimationViewModifier: ViewModifier {
	public var delay: Double = 0
	@State private var step = 0
	
	func body(content: Content) -> some View {
        content
			.opacity(step <= 1 ? 0 : 1)
			.overlay {
				GeometryReader { geometry in
					Rectangle()
						.fill(.black)
						.frame(maxWidth: [1].contains(step) ? .infinity : 0)
						.hAlign(step <= 1 ? .leading : .trailing)
						.animation(.easeInOut(duration: 0.3), value: step)
				}
			}
			.onAppear {
				DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
					step += 1
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
						step += 1
					}
				}
			}
    }
}

extension Text {
	func textAnimation(delay: Double = 0) -> some View {
		modifier(TextAnimationViewModifier(delay: delay))
	}
}

struct TitleAnimationViewModifier_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			Text("Text Animation View Modifier")
				.textAnimation()
			Text("Text Animation View Modifier")
				.textAnimation(delay: 0.2)
		}
    }
}
