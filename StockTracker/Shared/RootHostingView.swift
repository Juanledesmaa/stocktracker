//
//  RootHostingView.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

import SwiftUI

struct RootHostingView: View {
	@AppStorage("preferredColorScheme") private var preferredColorScheme = "system"

	let content: () -> AnyView

	private var colorScheme: ColorScheme? {
		switch preferredColorScheme {
		case "light": return .light
		case "dark": return .dark
		default: return nil
		}
	}

	var body: some View {
		content()
			.preferredColorScheme(colorScheme)
	}
}
