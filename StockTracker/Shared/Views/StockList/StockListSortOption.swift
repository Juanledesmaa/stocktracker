//
//  StockListSortOption.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

enum StockListSortOption: String, CaseIterable, Identifiable, CustomStringConvertible {
	case none = "None"
	case alphabeticalAscending = "A → Z"
	case alphabeticalDescending = "Z → A"
	case priceChangeAscending = "Price Change ▲"
	case priceChangeDescending = "Price Change ▼"
	case priceAscending = "Price ▲"
	case priceDescending = "Price ▼"

	var id: String { rawValue }
	var description: String { rawValue }

	var accessibilityDescription: String {
		switch self {
		case .none:
			return "No sorting"
		case .alphabeticalAscending:
			return "Alphabetical ascending"
		case .alphabeticalDescending:
			return "Alphabetical descending"
		case .priceChangeAscending:
			return "Price change ascending"
		case .priceChangeDescending:
			return "Price change descending"
		case .priceAscending:
			return "Price ascending"
		case .priceDescending:
			return "Price descending"
		}
	}
}

