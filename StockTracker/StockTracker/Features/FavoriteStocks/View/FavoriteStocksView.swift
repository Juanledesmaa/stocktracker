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
		StockListRefreshableList(
			stocks: [],
			onRefresh: {
//				await viewModel.loadStocks()
			},
			onToggleFavorite: { stock in
//				viewModel.toggleFavorite(for: stock)
			}
		)
	}
}
