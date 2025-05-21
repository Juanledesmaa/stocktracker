//
//  EmptyStateView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct EmptyStateView: View {
	let title: String
	var subTitle: String?
	let imageName: String
	var imageSize: CGSize?
	let onRefresh: () async -> Void

	var body: some View {
		CenteredVerticalScrollView {
			PlaceholderView(
				imageName: imageName,
				imageSize: imageSize,
				title: title,
				subtitle: subTitle
			)
			.accessibilityElement()
			.accessibilityLabel(accessibilityText)
		} onRefresh: {
			await onRefresh()
		}
	}
	
	private var accessibilityText: String {
		return "\(title); \(subTitle ?? "")"
	}
}
