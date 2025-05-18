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
			VStack(content: {
				Text("Awesome Stocket tracker list goes here!!")
			})
			.navigationTitle("STOCK TRACKER")
			.background(.black)
		}
		.task {
			await viewModel.loadStocks()
		}
	}
}
