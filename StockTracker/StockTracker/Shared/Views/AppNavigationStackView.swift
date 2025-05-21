//
//  AppNavigationStackView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct AppNavigationStack<Content: View>: View {
	let logoImageName: String
	let content: () -> Content

	init(
		logoImageName: String = "StockTracker_horizontal",
		@ViewBuilder content: @escaping () -> Content
	) {
		self.logoImageName = logoImageName
		self.content = content
	}

	var body: some View {
		NavigationStack {
			content()
				.toolbar {
					ToolbarItem(placement: .principal) {
						Image(logoImageName)
							.resizable()
							.scaledToFit()
							.frame(height: 48)
					}
				}
		}
	}
}
