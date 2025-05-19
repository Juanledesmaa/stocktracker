//
//  RootTabView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct RootTabView: View {
	let tabs: [TabItem]

	var body: some View {
		TabView {
			ForEach(Array(tabs.enumerated()), id: \.offset) { _, tab in
				tab.view
					.tabItem {
						Label(tab.label, systemImage: tab.systemImage)
					}
			}
		}
	}
}
