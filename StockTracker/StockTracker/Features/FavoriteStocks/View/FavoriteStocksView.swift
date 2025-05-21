//
//  FavoriteStocksView.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUI

struct FavoriteStocksView: View {
	@StateObject private var viewModel: FavoriteStocksViewModel

	init(viewModel: FavoriteStocksViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}

	var body: some View {
		content
			.background(Color.appColor.primaryBackground)
			.task {
				// TODO: Load Favorites
			}
	}
	
	@ViewBuilder
	private var content: some View {
		AppNavigationStack {
			StockList(configuration: .init(
				featuredStocks: [],
				allStocks: [],
				headerTitle: "Your favorite Stocks",
				onToggleFavorite: nil,
				onRefresh: {
					print("Pull to Refresh method")
				}
			))
		}
	}
}


