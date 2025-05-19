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
		NavigationView {
			content
			.navigationTitle("STOCK TRACKER")
			.background(Color.appColor.primaryBackground)
		}
		.task {
			await viewModel.loadStocks()
		}
	}
	
	@ViewBuilder
	private var content: some View {
		StockListRefreshableList(
			stocks: viewModel.shownStocks,
			onRefresh: {
				await viewModel.loadStocks()
			},
			onToggleFavorite: { stock in
				print("I Would love to add this favorite: \(stock)")
			}
		)
	}
}
