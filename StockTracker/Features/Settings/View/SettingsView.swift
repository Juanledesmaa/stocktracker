//
//  SettingsView.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

import SwiftUI

struct SettingsView: View {
	@AppStorage("preferredColorScheme") private var preferredColorScheme: String = "system"
	@AppStorage("mockAPIResponse") private var mockAPIResponse: String = MockAPIResponse.success.rawValue
	
	var body: some View {
		AppNavigationStack {
			content
		}
		.background(Color.appColor.primaryBackground)
	}
	
	@ViewBuilder
	private var content: some View {
		Form {
			Section(header: Text("Appearance")) {
				Picker("Theme", selection: $preferredColorScheme) {
					Text("System").tag("system")
					Text("Light").tag("light")
					Text("Dark").tag("dark")
				}
				.pickerStyle(.menu)
			}

			Section(header: Text("Mock API Response")) {
				Picker("Simulate Response", selection: $mockAPIResponse) {
					ForEach(MockAPIResponse.allCases) { option in
						Text(option.rawValue).tag(option.rawValue)
					}
				}
				.pickerStyle(.menu)
			}
		}
	}
}
