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
		AppNavigationStack {
			content
		}
		.background(Color.appColor.primaryBackground)
		.task {
			viewModel.loadFavorites()
		}
	}

	@ViewBuilder
	private var content: some View {
		switch viewModel.state {
		case .idle, .loading:
				ProgressView(viewModel.viewData.progressViewText)

		case .empty:
			EmptyStateView(
				title: viewModel.viewData.emptyFavoritesTitle,
				imageName: viewModel.viewData.emptyImageName,
				imageSize: viewModel.viewData.emptyImageSize,
				onRefresh: {
					viewModel.loadFavorites()
				}
			)

		case .loaded(let favorites):
			StockList(configuration: .init(
				featuredStocks: [],
				allStocks: favorites,
				headerTitle: viewModel.viewData.listHeaderTitle,
				selectedSort: viewModel.currentSort,
				onToggleFavorite: { stock in
					viewModel.toggleFavorite(stock)
				},
				onRefresh: nil,
				onSortChange: { sortOption in
					viewModel.applySort(sortOption)
				}
			))
		}
	}
}



