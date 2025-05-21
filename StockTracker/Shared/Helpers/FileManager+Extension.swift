//
//  FileManager+Extension.swift
//  StockTracker
//
//  Created by Juanito on 5/20/25.
//

import Foundation

extension FileManager {
	static var documentsDirectory: URL {
		guard let url = FileManager.default.urls(
			for: .documentDirectory, in: .userDomainMask
		).first else {
			fatalError("Failed to locate document directory.")
		}

		return url
	}
}
