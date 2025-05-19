//
//  StockListRefreshableList.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct StockListRefreshableList: View {
	let stocks: [Stock]
	let onRefresh: () async -> Void
	let onToggleFavorite: (Stock) -> Void

	var body: some View {
		List(stocks) { stock in
			VStack(spacing: 0) {
				StockCellView(
					stock: stock,
					onToggleFavorite: {
						onToggleFavorite(stock)
					}
				)
				
				Rectangle()
					.fill(Color.gray.opacity(0.2))
					.frame(height: 0.5)
					.padding(.horizontal, 8)
			}
			.listRowSeparator(.hidden)
		}
		.listStyle(.plain)
		.animation(.easeInOut, value: stocks)
		.scrollDismissesKeyboard(.interactively)
		.refreshable {
			await onRefresh()
		}
	}
}
