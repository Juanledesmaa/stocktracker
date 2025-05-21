//
//  FeaturedStockCellView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct FeaturedStockCellView: View {
	let stock: Stock
	
	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading, spacing: 2) {
					Text(stock.name)
						.font(.footnote)
						.foregroundColor(Color(.label))
					
					Text(stock.ticker)
						.font(.caption)
						.foregroundColor(Color(.label))
						.lineLimit(1)
				}
				
				Spacer()
				
				VStack(alignment: .trailing, spacing: 2) {
					Text("$\(stock.price)")
						.font(.footnote)
						.foregroundColor(Color(.label))

					Text(formattedChange)
						.font(.caption)
						.foregroundColor(.black)
						.padding(.horizontal, 6)
						.padding(.vertical, 2)
						.background(
							stock.priceChange24Hrs >= 0
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
	}
	
	private var formattedChange: String {
		let sign = stock.priceChange24Hrs >= 0 ? "+" : ""
		return "\(sign)\(stock.priceChange24Hrs)"
	}
}

