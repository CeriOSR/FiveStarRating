//
//  ViewController.swift
//  FiveStarRating
//
//  Created by Rey Cerio on 2018-09-28.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //(screensize - width) / 2
    let fiveStarRating = FiveStarRating(frame: CGRect(x: ((Int(UIScreen.main.bounds.width)) - Int((5*kStarSize) + (4*kSpacing))) / 2, y: 100, width: Int((5*kStarSize) + (4*kSpacing)), height: Int(kStarSize)))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(fiveStarRating)
    }


}

