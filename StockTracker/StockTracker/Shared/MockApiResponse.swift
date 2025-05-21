//
//  MockApiResponse.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

enum MockAPIResponse: String, CaseIterable, Identifiable {
	case success = "Success"
	case error = "Error"
	case empty = "Empty"
	case longDelay = "Long Delay"

	var id: String { rawValue }
}
