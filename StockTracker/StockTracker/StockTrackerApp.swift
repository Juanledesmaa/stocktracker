//
//  StockTrackerApp.swift
//  StockTracker
//
//  Created by Juanito on 5/17/25.
//

import SwiftUI

@main
struct StockTrackerApp: App {
    var body: some Scene {
        WindowGroup {
			let dataSource = StockListDataSource()
			let stockListService = StockListService(dataSource: dataSource)
			let viewModel = StockListViewModel(
				service: stockListService
			)
			StockListView(viewModel: viewModel)
        }
    }
}
