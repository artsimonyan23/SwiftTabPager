//
//  TabButton.swift
//  SwiftTabPager
//
//  Created by ArtS on 10/29/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit

class TabButton: UIButton {
    
    var selectedTextColor: UIColor? { willSet { setTitleColor(newValue, for: .normal) } }
    var selectedBackgroundColor: UIColor? { willSet { backgroundColor = newValue } }
    var selectedBorderWidth: CGFloat? { willSet { if let newValue = newValue { layer.borderWidth = newValue } } }
    var selectedBorderCornerRadius: CGFloat? { willSet { if let newValue = newValue { layer.cornerRadius = newValue } } }
    var selectedBorderColor: UIColor? { willSet { layer.borderColor = newValue?.cgColor } }
    var selectedTextFont: UIFont? { willSet { titleLabel?.font = newValue } }
    var unselectedTextColor: UIColor? { willSet { setTitleColor(newValue, for: .normal) } }
    var unselectedBackgroundColor: UIColor? { willSet { backgroundColor = newValue } }
    var unselectedBorderWidth: CGFloat? { willSet { if let newValue = newValue { layer.borderWidth = newValue } } }
    var unselectedBorderCornerRadius: CGFloat? { willSet { if let newValue = newValue { layer.cornerRadius = newValue } } }
    var unselectedBorderColor: UIColor? { willSet { layer.borderColor = newValue?.cgColor } }
    var unselectedTextFont: UIFont? { willSet { titleLabel?.font = newValue } }
    
    override var isEnabled: Bool {
        didSet {
            setButton(isEnabled: isEnabled)
        }
    }
    
    private func setButton(isEnabled: Bool) {
        if !isEnabled {
            setTitleColor(selectedTextColor, for: .normal)
            backgroundColor = selectedBackgroundColor
            if let selectedBorderWidth = selectedBorderWidth {
                layer.borderWidth = selectedBorderWidth
            }
            if let selectedBorderCornerRadius = selectedBorderCornerRadius {
                layer.cornerRadius = selectedBorderCornerRadius
            }
            layer.borderColor = selectedBorderColor?.cgColor
            titleLabel?.font = selectedTextFont
        } else {
            setTitleColor(unselectedTextColor, for: .normal)
            backgroundColor = unselectedBackgroundColor
            if let unselectedBorderWidth = unselectedBorderWidth {
                layer.borderWidth = unselectedBorderWidth
            }
            if let unselectedBorderCornerRadius = unselectedBorderCornerRadius {
                layer.cornerRadius = unselectedBorderCornerRadius
            }
            layer.borderColor = unselectedBorderColor?.cgColor
            titleLabel?.font = unselectedTextFont
        }
    }

}
