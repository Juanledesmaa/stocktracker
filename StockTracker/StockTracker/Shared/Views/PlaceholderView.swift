//
//  PlaceholderView.swift
//  StockTracker
//
//  Created by Juanito on 5/19/25.
//

import SwiftUI

struct PlaceholderView: View {
	
	private var imageName: String?
	private var title: String?
	private var subtitle: String?
	private let imageSize: CGSize
	private static let defaultImageSize = CGSize(width: 200, height: 200)
	private let alignment: Alignment

	init(
		imageName: String? = nil,
		imageSize: CGSize? = nil,
		title: String? = nil,
		subtitle: String? = nil,
		alignment: Alignment = .center) {
		self.imageName = imageName
		self.title = title
		self.subtitle = subtitle
		self.imageSize = imageSize ?? PlaceholderView.defaultImageSize
		self.alignment = alignment
	}

	var body: some View {
		VStack(spacing: 24) {
			if let imageName = imageName {
				Image(imageName, bundle: .main)
					.resizable()
					.scaledToFit()
					.clipped()
					.frame(width: imageSize.width, height: imageSize.height)
			}
			
			VStack(spacing: 16) {
				if let title = title {
					Text(title)
						.multilineTextAlignment(.center)
						.frame(maxWidth: .infinity, alignment: .center)
						.font(.system(size: 24, weight: .semibold))
				}
				
				if let subtitle = subtitle {
					Text(subtitle)
						.foregroundStyle(.opacity(0.7))
						.multilineTextAlignment(.center)
						.frame(maxWidth: .infinity, alignment: .center)
						.font(.system(size: 18, weight: .regular))
				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
	}
}
