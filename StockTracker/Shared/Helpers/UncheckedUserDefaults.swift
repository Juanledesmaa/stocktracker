//
//  UncheckedUserDefaults.swift
//  StockTracker
//
//  Created by Juanito on 5/21/25.
//

import Foundation

/// A simple wrapper to mark `UserDefaults` as `@unchecked Sendable`.
///
/// Use this when you need to access `UserDefaults` in a detached task and
/// you're sure it's used in a read-only and safe way.
final class UncheckedUserDefaults: @unchecked Sendable {
	/// The wrapped `UserDefaults` instance.
	let value: UserDefaults

	/// Initializes the wrapper with a `UserDefaults` instance (default is `.standard`).
	init(_ value: UserDefaults = .standard) {
		self.value = value
	}
}
