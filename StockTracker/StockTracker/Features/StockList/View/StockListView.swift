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
		Text("I'm gonna be an awesome stock list View soon...")
	}
}
