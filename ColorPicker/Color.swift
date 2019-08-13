//
//  Color.swift
//  ColorPicker
//
//  Created by Michael Redig on 5/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

struct Color {
	static func getHueSaturation(at offset: CGSize) -> (hue: CGFloat, saturation: CGFloat) {
		let saturation = sqrt(offset.width * offset.width + offset.height * offset.height)
		var hue = acos(offset.width / saturation) / (2.0 * CGFloat.pi)
		if offset.height < 0 { hue = 1.0 - hue }
		return (hue,saturation)
	}
}
