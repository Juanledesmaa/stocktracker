//
//  StockList.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct StockList: View {
	let configuration: Configuration
	
	struct Configuration {
		let featuredStocks: [StockDisplay]
		let allStocks: [StockDisplay]
		let headerTitle: String
		let selectedSort: StockListSortOption
		let onToggleFavorite: ((StockDisplay) -> Void)?
		let onRefresh: (() async -> Void)?
		let onSortChange: ((StockListSortOption) -> Void)?
	}

	@State private var selectedSort: StockListSortOption
	
	init(configuration: Configuration) {
		self.configuration = configuration
		_selectedSort = State(initialValue: configuration.selectedSort)
	}
	
	var body: some View {
		if let onRefresh = configuration.onRefresh {
			content
				.refreshable {
					await onRefresh()
				}
		} else {
			content
		}
	}
	
	@ViewBuilder
	private var content: some View {
		List {
			if !configuration.featuredStocks.isEmpty {
				FeaturedStocksView(stocks: configuration.featuredStocks)
					.listRowInsets(EdgeInsets())
					.listRowSeparator(.hidden)
					.padding(.vertical)
			}

			HStack {
				Text(configuration.headerTitle)
					.font(.title.bold())
					.foregroundColor(.primary)
					.accessibilityElement()
					.accessibilityLabel(configuration.headerTitle)
					.accessibilityAddTraits(.isHeader)

				Spacer()
				
				if configuration.onSortChange != nil {
					Menu {
						Picker(selection: $selectedSort, label: EmptyView()) {
							ForEach(StockListSortOption.allCases) { option in
								Text(option.description).tag(option)
									.accessibilityElement()
									.accessibilityLabel("\(option.accessibilityDescription)")
							}
						}
					} label: {
						HStack(spacing: 4) {
							Text("Sort By:")
								.fontWeight(.bold)
								.foregroundColor(Color(.label))
							
							Text(selectedSort.description)
								.foregroundColor(Color(.label))
						}
						.padding(.horizontal, 8)
						.padding(.vertical, 4)
						.background(Color.appColor.secondaryBackground)
						.cornerRadius(8)
						.accessibilityElement()
						.accessibilityLabel("Sort By: \(selectedSort.accessibilityDescription)")
					}
				}
			}
			.listRowSeparator(.hidden)
			.padding(.vertical, 8)
			
			ForEach(configuration.allStocks, id: \.id) { stockDisplay in
				StockCellView(
					stockDisplay: stockDisplay,
					onToggleFavorite: {
						configuration.onToggleFavorite?(stockDisplay)
					}
				)
				.listRowSeparator(.hidden)
			}
			.onChange(of: selectedSort) { _, newValue in
				configuration.onSortChange?(newValue)
			}
		}
		.listStyle(.plain)
		.animation(.easeInOut, value: configuration.allStocks.count)
	}
}
