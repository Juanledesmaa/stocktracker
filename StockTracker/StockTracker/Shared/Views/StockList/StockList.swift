//
//  StockListRefreshableList.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct StockList: View {
	let configuration: Configuration

	struct Configuration {
		let featuredStocks: [Stock]
		let allStocks: [Stock]
		let headerTitle: String
		let onToggleFavorite: ((Stock) -> Void)?
		let onRefresh: () async -> Void
	}
	
	@State private var placeholderBool = false

	var body: some View {
		List {
			if !configuration.featuredStocks.isEmpty {
				FeaturedStocksView(stocks: configuration.featuredStocks)
					.listRowInsets(EdgeInsets())
					.listRowSeparator(.hidden)
					.padding(.vertical)
			}

			Section(
				header: Text(configuration.headerTitle)
					.font(.title.bold())
					.foregroundColor(.primary)
					.padding(.vertical, 8)
			) {
				ForEach(configuration.allStocks) { stock in
					StockCellView(
						stock: stock,
						onToggleFavorite: {
							configuration.onToggleFavorite?(stock)
						},
						isFavorite: $placeholderBool
					)
					.listRowSeparator(.hidden)
				}
			}
		}
		.listStyle(.plain)
		.animation(.easeInOut, value: configuration.allStocks)
		.scrollDismissesKeyboard(.interactively)
		.refreshable {
			await configuration.onRefresh()
		}
	}
}
