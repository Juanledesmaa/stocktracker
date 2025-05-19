//
//  StockCellView.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct StockCellView: View {
	let stock: Stock
	let onToggleFavorite: () -> Void

	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 4) {
				Text(stock.name)
					.font(.headline)
				Text(stock.ticker)
					.font(.subheadline)
					.foregroundColor(.gray)
			}

			Spacer()

			VStack(alignment: .trailing, spacing: 4) {
				Text("$\(stock.price)")
					.font(.headline)
				Text(formattedChange)
					.font(.subheadline)
					.frame(minWidth: 50)
					.padding(6)
					.background(
						stock.priceChange24Hrs >= 0 ? Color.appColor.positiveGreen : Color.appColor.negativeRed
					)
					.cornerRadius(5)
			}

			Button(action: onToggleFavorite) {
				Image(systemName: stock.isFeatured ? "heart.fill" : "heart")
					.foregroundColor(stock.isFeatured ? .yellow : .gray)
			}
			.buttonStyle(PlainButtonStyle())
			.padding(.horizontal, 8)
		}
		.padding(.vertical, 8)
	}

	private var formattedChange: String {
		let sign = stock.priceChange24Hrs >= 0 ? "+" : ""
		return "\(sign)\(stock.priceChange24Hrs)"
	}
}
