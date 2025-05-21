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
				await viewModel.loadStocks()
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
						headerTitle: "All Stocks",
						onToggleFavorite: { stock in
							print("Favorited: \(stock)")
						},
						onRefresh: {
							//await viewModel.loadStocks()
						}
					))
					
				case .empty:
					EmptyStateView(
						title: viewModel.viewData.emptyStocksTitle,
						imageName: viewModel.viewData.emptyImageName
					) {
						await viewModel.loadStocks()
					}
					
				case .error(_):
					EmptyStateView(
						title: viewModel.viewData.errorTitle,
						subTitle: viewModel.viewData.errorTitle,
						imageName: viewModel.viewData.errorImageName,
						imageSize: viewModel.viewData.errorImageSize
					) {
						await viewModel.loadStocks()
					}
			}
		}
	}
}
