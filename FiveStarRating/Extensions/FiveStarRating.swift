//
//  FiveStarRating.swift
//  FiveStarRating
//
//  Created by Rey Cerio on 2018-09-28.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit

let kSpacing = 8.0
let kStarSize = 44.5

class FiveStarRating: UIStackView {
    
    var rating = 0 {
        didSet{
            updateButtonSelectionState()
        }
    }
    private var ratingButtons = [UIButton]()
    private var starCount = 5 {
        didSet{
            setupButtons()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        spacing = CGFloat(kSpacing)
        isUserInteractionEnabled = true
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    private func setupButtons() {
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }

        ratingButtons.removeAll()
        
//        self.axis = .horizontal
//        self.distribution = .fillEqually
        for index in 0..<starCount {
            let button = UIButton(type: .system)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setImage(#imageLiteral(resourceName: "emptyStar").withRenderingMode(.alwaysOriginal), for: .normal)
            button.setImage(#imageLiteral(resourceName: "filledStar").withRenderingMode(.alwaysOriginal), for: .selected)
            button.setImage(#imageLiteral(resourceName: "highlightedStar").withRenderingMode(.alwaysOriginal), for: .highlighted)
            button.setImage(#imageLiteral(resourceName: "highlightedStar"), for: [.highlighted, .selected])
            
//            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            
            
            button.accessibilityLabel = "Set \(index) + 1 Star Rating"
            
            button.heightAnchor.constraint(equalToConstant: CGFloat(kStarSize)).isActive = true
            button.widthAnchor.constraint(equalToConstant: CGFloat(kStarSize)).isActive = true

            addArrangedSubview(button)
            ratingButtons.append(button)

        }
        updateButtonSelectionState()
        
        //changing it to swipe the stackview rather than button press.
        let gr = UILongPressGestureRecognizer(target: self, action: #selector(handleSelection(_ :)))
        gr.minimumPressDuration = 0.1
        addGestureRecognizer(gr)
        
    }
    
    @objc func handleSelection(_ press: UILongPressGestureRecognizer) {
        //where the press is
        let location = press.location(in: self.superview)
        
        detectWhichStar(location: location)
        
        if press.state == .began {
            print("started")
        } else if press.state == .changed {
            print("continuing")
        } else {
            print("finished")
        }
    }
    
    private func detectWhichStar(location: CGPoint) {
        for (index, button) in ratingButtons.enumerated() {
            let frame = button.convert(button.bounds, to: self.superview)
            if frame.contains(location) {
                print("Star \(index) selected")
                rating = index + 1
            } else {
                print("Star \(index) not selected")
            }
        }
    }
    
    @objc func buttonTapped(button: UIButton) {
        print("Button tapped")
        //this may be depreciated soon. .index(of:) is not in the dropdown anymore
        guard let index = ratingButtons.index(of: button) else { fatalError("Button is not in the array of buttons.")}
        //actualy index from 1 not 0
        let selectedRating = index + 1
        if rating == selectedRating {
            rating = 0
        } else {
            rating = selectedRating
        }
        
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to 0."
            } else {
                hintString = nil
            }
            
            let valueString : String?
            switch (rating) {
            case 0: valueString = "No rating set."
            case 1: valueString = "One star set."
            default: valueString = "\(rating) stars set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
