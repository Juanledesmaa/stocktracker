//
//  FeaturedStockCellView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct FeaturedStockCellView: View {
	let stockDisplay: StockDisplay
	
	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading, spacing: 2) {
					Text(stockDisplay.stock.name)
						.font(.footnote)
						.foregroundColor(Color(.label))
					
					Text(stockDisplay.stock.ticker)
						.font(.caption)
						.foregroundColor(Color(.label))
						.lineLimit(1)
				}
				
				Spacer()
				
				VStack(alignment: .trailing, spacing: 2) {
					Text(formattedPrice)
						.font(.footnote)
						.foregroundColor(Color(.label))

					Text(formattedChange)
						.font(.caption)
						.foregroundColor(.black)
						.padding(.horizontal, 6)
						.padding(.vertical, 2)
						.background(
							stockDisplay.stock.priceChange24Hrs >= 0
								? Color.appColor.positiveGreen
								: Color.appColor.negativeRed
						)
						.cornerRadius(4)
						.lineLimit(1)
						.minimumScaleFactor(0.8)
				}
			}
		}
		.padding()
		.background(Color.appColor.secondaryBackground)
		.cornerRadius(12)
		.padding(.horizontal, 4)
		.accessibilityElement()
		.accessibilityLabel(accessibilityText)
	}
	
	private var formattedChange: String {
		let sign = stockDisplay.stock.priceChange24Hrs >= 0 ? "+" : ""
		return "\(sign)\(stockDisplay.stock.priceChange24Hrs)"
	}
	
	private var formattedPrice: String {
		"$\(stockDisplay.stock.price)"
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

