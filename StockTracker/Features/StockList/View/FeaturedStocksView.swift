//
//  FeaturedStocksView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct FeaturedStocksView: View {
	let stocks: [StockDisplay]

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text("Trending Now")
				.font(.headline)
				.padding(.horizontal)
				.accessibilityElement()
				.accessibilityLabel("Stocks that are trending now")
				.accessibilityAddTraits(.isHeader)
			ScrollView(.horizontal, showsIndicators: false) {
				LazyHStack(spacing: 0) {
					ForEach(stocks) { stockDisplay in
						FeaturedStockCellView(stockDisplay: stockDisplay)
					}
				}
				.padding(.horizontal)
			}
		}
	}
}
