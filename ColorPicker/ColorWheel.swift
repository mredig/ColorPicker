//
//  ColorWheel.swift
//  ColorPicker
//
//  Created by Michael Redig on 5/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

@IBDesignable class ColorWheel: UIControl {

	var color: UIColor = .white

	override func layoutSubviews() {
		super.layoutSubviews()

		clipsToBounds = true
		let radius = frame.width / 2
		layer.cornerRadius = radius
		layer.borderWidth = 1
		layer.borderColor = UIColor.black.cgColor
	}


	override func draw(_ rect: CGRect) {
		let scaleFactor: CGFloat = 1.0 / UIScreen.main.scale

		for y in stride(from: 0, to: bounds.maxY, by: scaleFactor) {
			for x in stride(from: 0, to: bounds.maxX, by: scaleFactor) {
				let color = self.color(for: CGPoint(x: x, y: y))
				let pixel = CGRect(x: x, y: y, width: scaleFactor, height: scaleFactor)
				color.setFill()
				UIRectFill(pixel)
			}
		}
	}

	// MARK: - Touch Tracking

	override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let touchPoint = touch.location(in: self)
		if bounds.contains(touchPoint) {
			color = self.color(for: touchPoint)
			sendActions(for: [.touchDown, .valueChanged])
		} else {
			sendActions(for: [.touchDragOutside])
		}
		return true
	}

	override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
		let touchPoint = touch.location(in: self)
		if bounds.contains(touchPoint) {
			color = self.color(for: touchPoint)
			sendActions(for: [.touchDragInside, .valueChanged])
		} else {
			sendActions(for: [.touchDragOutside])
		}
		return true
	}

	override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
		defer {
			super.endTracking(touch, with: event)
		}

		guard let touch = touch else { return }
		let touchPoint = touch.location(in: self)
		if bounds.contains(touchPoint) {
			color = self.color(for: touchPoint)
			sendActions(for: [.touchUpInside, .valueChanged])
		} else {
			sendActions(for: [.touchUpOutside])
		}
	}

	override func cancelTracking(with event: UIEvent?) {
		sendActions(for: [.touchCancel])
	}

	// MARK: - Private

	private func color(for location: CGPoint) -> UIColor {
		let center = CGPoint(x: bounds.midX, y: bounds.midY)
		let dy = location.y - center.y
		let dx = location.x - center.x
		let offset = CGSize(width: dx / center.x, height: dy / center.y)
		if offset == CGSize.zero {
			return UIColor(hue: 0, saturation: 0, brightness: 0.8, alpha: 1.0)
		}
		let (hue, saturation) = Color.getHueSaturation(at: offset)
		return UIColor(hue: hue, saturation: saturation, brightness: 0.8, alpha: 1.0)
	}
}
