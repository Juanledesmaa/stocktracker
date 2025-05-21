//
//  View+Extension.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

import SwiftUI

extension String {
	/// Returns the string with each character separated by spaces, useful for accessibility
	var spelledOut: String {
		self.map { String($0) }.joined(separator: " ")
	}
}

