//
//  ViewController.swift
//  ColorPicker
//
//  Created by Michael Redig on 5/14/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var myWheel: ColorWheel!


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	@IBAction func changeColor(_ sender: ColorWheel) {
		view.backgroundColor = sender.color
	}

}

