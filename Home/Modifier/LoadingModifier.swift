//
//  LoadingModifier.swift
//  Home
//
//  Created by Perso on 26/02/2023.
//

import SwiftUI



struct LoadingModifier: ViewModifier {
	public var isLoading: Bool = true
	
	func body(content: Content) -> some View {
		ZStack {
			content
			
			if isLoading {
				VStack {
					VStack {
						ProgressView()
						Text("loading")
							.padding(.top)
					}
					.padding(20)
					.background(.background)
					.mask(RoundedRectangle(cornerRadius: 8, style: .circular))
					.shadow(color: .black.opacity(0.2), radius: 8)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(.ultraThinMaterial)
				.animation(.default, value: isLoading)
				.ignoresSafeArea()
			}
		}
			
	}
}

struct LoadingModifier_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			Text("LoadingModifier")
		}
		.modifier(LoadingModifier(isLoading: true))
    }
}
