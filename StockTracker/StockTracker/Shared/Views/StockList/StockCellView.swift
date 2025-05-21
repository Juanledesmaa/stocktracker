//
//  StockCellView.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct StockCellView: View {
	let stock: Stock
	let onToggleFavorite: (() -> Void)?
	@Binding var isFavorite: Bool
	
	var body: some View {
		VStack {
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
						.foregroundColor(.black)
						.frame(minWidth: 50)
						.padding(6)
						.background(
							stock.priceChange24Hrs >= 0 ? Color.appColor.positiveGreen : Color.appColor.negativeRed
						)
						.cornerRadius(5)
				}
				
				if let onToggleFavorite = onToggleFavorite {
					Button(action: {
						isFavorite.toggle()
						onToggleFavorite()
					}) {
						Image(systemName: isFavorite ? "star.fill" : "star")
							.foregroundColor(isFavorite ? .yellow : .gray)
					}
					.buttonStyle(PlainButtonStyle())
					.padding(.horizontal, 8)
				}
			}
			Rectangle()
				.fill(Color.gray.opacity(0.2))
				.frame(height: 0.5)
				.padding(0)
		}
	}

	private var formattedChange: String {
		let sign = stock.priceChange24Hrs >= 0 ? "+" : ""
		return "\(sign)\(stock.priceChange24Hrs)"
	}
}
