//
//  StockCellView.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct StockCellView: View {
	let stockDisplay: StockDisplay
	let onToggleFavorite: (() -> Void)?
	
	var body: some View {
		VStack(spacing: 8) {
			HStack {
				HStack {
					VStack(alignment: .leading, spacing: 4) {
						Text(stockDisplay.stock.name)
							.font(.headline)
						Text(stockDisplay.stock.ticker)
							.font(.subheadline)
							.foregroundColor(.gray)
					}
					
					Spacer()
					
					VStack(alignment: .trailing, spacing: 4) {
						Text(formattedPrice)
							.font(.headline)
						Text(formattedChange)
							.font(.subheadline)
							.foregroundColor(.black)
							.frame(minWidth: 50)
							.padding(6)
							.background(
								stockDisplay.stock.priceChange24Hrs >= 0
								? Color.appColor.positiveGreen
								: Color.appColor.negativeRed
							)
							.cornerRadius(5)
					}
				}
				.accessibilityElement()
				.accessibilityLabel(accessibilityText)
				
				if let onToggleFavorite = onToggleFavorite {
					Button(action: {
						let generator = UIImpactFeedbackGenerator(style: .light)
						generator.impactOccurred()
						onToggleFavorite()
					}) {
						Image(systemName: stockDisplay.isFavorite ? "star.fill" : "star")
							.resizable()
							.frame(width: 28, height: 28)
							.foregroundColor(stockDisplay.isFavorite ? .yellow : .gray)
					}
					.accessibilityLabel(accessibilityButtonText)
					.accessibilityAddTraits(.isButton)
					.buttonStyle(.plain)
					.padding(.horizontal, 8)
				}
			}
			
			Divider()
				.background(Color.gray.opacity(0.2))
		}
	}
	
	private var formattedChange: String {
		let sign = stockDisplay.stock.priceChange24Hrs >= 0 ? "+" : ""
		return "\(sign)\(stockDisplay.stock.priceChange24Hrs)"
	}
	
	private var formattedPrice: String {
		"$\(stockDisplay.stock.price)"
	}
	
	private var accessibilityButtonText: String {
		return stockDisplay.isFavorite ? "Remove \(stockDisplay.stock.name) from favorites" : "Add \(stockDisplay.stock.name) to favorites"
	}
	
	private var accessibilityText: String {
		let change = stockDisplay.stock.priceChange24Hrs
		let direction: String = {
			if change == 0 {
				return "no change in price"
			} else if change > 0 {
				return "up by \(change)"
			} else {
				return "down by \(abs(change))"
			}
		}()
		return "\(stockDisplay.stock.name); ticker; \(stockDisplay.stock.ticker.spelledOut). \(formattedPrice). \(direction)"
	}
}
