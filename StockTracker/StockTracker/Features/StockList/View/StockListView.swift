//
//  StockListView.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import SwiftUI

struct StockListView: View {
	
	@StateObject private var viewModel: StockListViewModel
	
	init(viewModel: StockListViewModel) {
		_viewModel = StateObject(wrappedValue: viewModel)
	}
	
	var body: some View {
		content
			.background(Color.appColor.primaryBackground)
			.task {
				await viewModel.loadStocks(force: false)
			}
	}
	
	@ViewBuilder
	private var content: some View {
		AppNavigationStack {
			switch viewModel.state {
				case .idle, .loading:
					ProgressView(viewModel.viewData.progressViewText)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
					
				case .loaded(let featuredStocks, let allStocks):
					StockList(configuration: .init(
						featuredStocks: featuredStocks,
						allStocks: allStocks,
						headerTitle: viewModel.viewData.listHeaderTitle,
						selectedSort: viewModel.currentSort,
						onToggleFavorite: { stock in
							viewModel.toggleFavorite(stock)
						},
						onRefresh: {
							await viewModel.loadStocks(force: true)
						},
						onSortChange: { sortOption in
							viewModel.applySort(sortOption)
						}
					))
				case .empty:
					EmptyStateView(
						title: viewModel.viewData.emptyStocksTitle,
						imageName: viewModel.viewData.emptyImageName
					) {
						await viewModel.loadStocks(force: true)
					}
					
				case .error(_):
					EmptyStateView(
						title: viewModel.viewData.errorTitle,
						subTitle: viewModel.viewData.errorSubtitle,
						imageName: viewModel.viewData.errorImageName,
						imageSize: viewModel.viewData.errorImageSize
					) {
						await viewModel.loadStocks(force: true)
					}
			}
		}
	}
}
