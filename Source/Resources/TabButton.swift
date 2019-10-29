//
//  TabButton.swift
//  SwiftTabPager
//
//  Created by ArtS on 10/29/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit

class TabButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            setButton(isEnabled: isEnabled)
        }
    }

    private var selectedTitleColor: UIColor
    private var selectedBackgroundColor: UIColor
    private var unselectedTitleColor: UIColor
    private var unselectedBackgroundColor: UIColor

    init(selectedColor: (title: UIColor, background: UIColor), unselectedColor: (title: UIColor, background: UIColor)) {
        selectedTitleColor = selectedColor.title
        selectedBackgroundColor = selectedColor.background
        unselectedTitleColor = unselectedColor.title
        unselectedBackgroundColor = unselectedColor.background
        super.init(frame: CGRect.zero)
        setButton(isEnabled: isEnabled)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton(isEnabled: Bool) {
        if !isEnabled {
            setTitleColor(selectedTitleColor, for: .normal)
            backgroundColor = selectedBackgroundColor
        } else {
            setTitleColor(unselectedTitleColor, for: .normal)
            backgroundColor = unselectedBackgroundColor
        }
    }

}
