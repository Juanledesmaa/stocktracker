//
//  FeaturedStocksView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct FeaturedStocksView: View {
	let stocks: [Stock]

	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
			Text("Trending Now")
				.font(.headline)
				.padding(.horizontal)
			ScrollView(.horizontal, showsIndicators: false) {
				LazyHStack(spacing: 0) {
					ForEach(stocks) { stock in
						FeaturedStockCellView(stock: stock)
					}
				}
				.padding(.horizontal)
			}
		}
	}
}
