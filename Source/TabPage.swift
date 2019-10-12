//
//  TabPager.swift
//  TabPager
//
//  Created by Arthur Simonyan on Oct 10, 2019.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit
// import IBPCollectionViewCompositionalLayout
// import Closures

@IBDesignable
public class TabPage: UIView {
    @IBInspectable public var selectedTextColor: UIColor = .black

    @IBInspectable public var selectedBackgroundColor: UIColor = .white

    @IBInspectable public var unselectedTextColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)

    @IBInspectable public var unselectedBackgroundColor: UIColor = .white

    @IBInspectable public var textFont: UIFont?

    @IBInspectable public var indicatorColor: UIColor = UIColor.black

    @IBInspectable public var indicatorIsAtBottom: Bool = true

    @IBInspectable public var indicatorSizeFitTitleWidth: Bool = false

    @IBInspectable public var indicatorHeight: CGFloat = 1.0

    @IBInspectable public var indicatorWidth: CGFloat = -1

    @IBInspectable public var indicatorOffset: CGFloat = 0

    @IBInspectable public var horizontalSpacing: CGFloat = 0

    @IBInspectable public var horizontalSpacingFromBorders: Bool = false

    @IBInspectable public var verticalSpacing: CGFloat = 0

    @IBInspectable public var barBorderWidth: CGFloat = 0

    @IBInspectable public var barBorderCornerRadius: CGFloat = 0

    @IBInspectable public var barBorderColor: UIColor = .black

    @IBInspectable public var itemBorderWidth: CGFloat = 0

    @IBInspectable public var itemBorderCornerRadius: CGFloat = 0

    @IBInspectable public var itemBorderColor: UIColor = .black

    @IBInspectable public var animationDuration: Double = 0.2

    public typealias SegmentedViewHandler = ((_ selectedIndex: Int) -> Void)

    private var itemTitles: [String]? {
        didSet {
            layer.borderColor = barBorderColor.cgColor
            layer.borderWidth = barBorderWidth
            layer.cornerRadius = barBorderCornerRadius
            createButtons()
            createSelectedLine()
            //                layoutIfNeeded()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    private var selectedIndex = 0 {
        willSet {
            guard segmentButtons?.count ?? 0 > newValue, newValue >= 0 else { return }
            if let button = segmentButtons?[newValue] {
                button.isEnabled = false
            }
        }
        didSet {
            guard segmentButtons?.count ?? 0 > oldValue, oldValue >= 0 else { return }
            if let previewButton = segmentButtons?[oldValue] {
                previewButton.isEnabled = true
            }
        }
    }

    private var segmentButtons: [UIButton]?

    private var segmentViewAction: SegmentedViewHandler?
    private let selectedLineView = UIView()
    private var selectedLineViewCenterXAnchor: NSLayoutConstraint?
    private var selectedLineViewWidthAnchor: NSLayoutConstraint?

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setTitles(titles: ["One", "Two", "Three"]) { _ in }
    }

    public func setTitles(titles: [String], completion: @escaping SegmentedViewHandler) {
        itemTitles = titles.filter({ !$0.isEmpty })
        segmentViewAction = completion
    }

    private func createButtons() {
        guard let itemTitles = itemTitles else { return }
        segmentButtons = []
        for i in 0 ..< itemTitles.count {
            let button = TabButton(selectedColor: (title: selectedTextColor, background: selectedBackgroundColor), unselectedColor: (title: unselectedTextColor, background: unselectedBackgroundColor))
            addSubview(button)
            segmentButtons?.append(button)
            button.titleLabel?.font = textFont
            button.tag = i + 1
            button.layer.borderColor = itemBorderColor.cgColor
            button.layer.borderWidth = itemBorderWidth
            button.layer.cornerRadius = itemBorderCornerRadius
            button.addTarget(self, action: #selector(appNavigationButtonAction(_:)), for: .touchUpInside)
            button.setTitle(itemTitles[i], for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.topAnchor.constraint(equalTo: topAnchor, constant: verticalSpacing).isActive = true
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalSpacing).isActive = true
            if i == 0 {
                button.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalSpacingFromBorders ? horizontalSpacing : 0).isActive = true
                button.isEnabled = false
            } else {
                let previewButton = viewWithTag(i)!
                button.leftAnchor.constraint(equalTo: previewButton.rightAnchor, constant: horizontalSpacing).isActive = true
                button.widthAnchor.constraint(equalTo: previewButton.widthAnchor).isActive = true
            }
            if i == itemTitles.count - 1 {
                button.rightAnchor.constraint(equalTo: rightAnchor, constant: -(horizontalSpacingFromBorders ? horizontalSpacing : 0)).isActive = true
            }
        }
    }

    private func createSelectedLine() {
        selectedLineView.removeFromSuperview()

        guard let itemTitles = itemTitles, itemTitles.count > 0, let button = segmentButtons?.first else { return }
        addSubview(selectedLineView)
        selectedLineView.backgroundColor = indicatorColor
        selectedLineView.translatesAutoresizingMaskIntoConstraints = false
        selectedLineView.heightAnchor.constraint(equalToConstant: indicatorHeight).isActive = true
        if indicatorWidth < 0 {
            selectedLineViewWidthAnchor = selectedLineView.widthAnchor.constraint(equalTo: button.widthAnchor)
            selectedLineViewWidthAnchor?.isActive = true
        } else {
            selectedLineViewWidthAnchor = selectedLineView.widthAnchor.constraint(equalToConstant: indicatorWidth)
            selectedLineViewWidthAnchor?.isActive = true
        }
        if indicatorIsAtBottom {
            selectedLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: indicatorOffset).isActive = true
        } else {
            selectedLineView.topAnchor.constraint(equalTo: topAnchor, constant: indicatorOffset).isActive = true
        }
    }

    @objc private func appNavigationButtonAction(_ sender: UIButton) {
        selectedIndex = sender.tag - 1
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
            self.scrollSelectedLineToIndex(index: self.selectedIndex)
            self.layoutSubviews()
        }, completion: nil)
        segmentViewAction?(selectedIndex)
    }

    private func scrollSelectedLineToIndex(index: Int) {
        guard let segmentButtons = segmentButtons else { return }

        let button = segmentButtons[index]

        selectedLineViewCenterXAnchor?.isActive = false
        selectedLineViewCenterXAnchor = selectedLineView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        selectedLineViewCenterXAnchor?.isActive = true

        if indicatorSizeFitTitleWidth {
            let button = segmentButtons[index]
            guard let string = button.titleLabel?.text else { return }
            guard let font = button.titleLabel?.font else { return }
            let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
            selectedLineViewWidthAnchor?.isActive = false
            selectedLineViewWidthAnchor = selectedLineView.widthAnchor.constraint(equalToConstant: size.width)
            selectedLineViewWidthAnchor?.isActive = true
        }
    }

    fileprivate class TabButton: UIButton {
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
}
