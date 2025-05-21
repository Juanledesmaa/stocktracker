//
//  Color+Extension.swift
//  StockTracker
//
//  Created by Juanito on 5/18/25.
//

import SwiftUICore

extension Color {
	
	static let appColor = Color.AppColor()

	struct AppColor {
		let primaryBackground = Color("PrimaryBackground")
		let secondaryBackground = Color("SecondaryBackground")
		let positiveGreen = Color("PositiveGreen")
		let negativeRed = Color("NegativeRed")
	}
}
