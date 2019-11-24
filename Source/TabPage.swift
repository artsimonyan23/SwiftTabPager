//
//  TabPager.swift
//  TabPager
//
//  Created by Arthur Simonyan on Oct 10, 2019.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit

@IBDesignable
public class TabPage: UIView {
    
    @IBInspectable public var selectedTextColor: UIColor = .black { didSet { createButtons() } }

    @IBInspectable public var selectedBackgroundColor: UIColor = .white { didSet { createButtons() } }

    @IBInspectable public var unselectedTextColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2) { didSet { createButtons() } }

    @IBInspectable public var unselectedBackgroundColor: UIColor = .white { didSet { createButtons() } }
    
    @IBInspectable public var textFont: UIFont? { didSet { createButtons() } }
    
    @IBInspectable public var indicatorColor: UIColor = UIColor.black {
        didSet {
            createSelectedLine()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorIsAtBottom: Bool = true {
        didSet {
            createSelectedLine()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorSizeFitTitleWidth: Bool = false {
        didSet {
            createSelectedLine()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorHeight: CGFloat = 1.0 {
        didSet {
            createSelectedLine()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorWidth: CGFloat = -1 {
        didSet {
            createSelectedLine()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorOffset: CGFloat = 0 {
        didSet {
            createSelectedLine()
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var horizontalSpacing: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var horizontalSpacingFromBorders: Bool = false { didSet { createButtons() } }

    @IBInspectable public var verticalSpacing: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var barBorderWidth: CGFloat {
        set { layer.borderWidth = newValue  }
        get { return layer.borderWidth }
    }

    @IBInspectable public var barBorderCornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }

    @IBInspectable public var barBorderColor: UIColor {
        set { layer.borderColor = newValue.cgColor  }
        get { return UIColor(cgColor: layer.borderColor!) }
    }

    @IBInspectable public var itemBorderWidth: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var itemBorderCornerRadius: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var itemBorderColor: UIColor = .black { didSet { createButtons() } }

    @IBInspectable public var animationDuration: Double = 0.2

    public typealias SegmentedViewHandler = ((_ selectedIndex: Int) -> Void)
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setTitles(titles: ["One", "Two", "Three"]) { _ in }
    }

    public func setTitles(titles: [String], completion: @escaping SegmentedViewHandler) {
        itemTitles = titles.filter({ !$0.isEmpty })
        segmentViewAction = completion
    }
    
    public func setWithControllersOn(scrollView: UIScrollView, data: [(title: String, controller: UIViewController)], completion: @escaping SegmentedViewHandler) {
        itemTitles = data.compactMap({$0.title})
        segmentViewAction = completion
        self.scrollView = scrollView
        self.controllers = data.compactMap({$0.controller})
        setupControllers()
    }
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            offsetToken?.invalidate()
        }
    }
    
    public var segmentButtons: [UIButton]?

    
    // private properties
    
    private var itemTitles: [String]? {
        didSet {
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

    private var segmentViewAction: SegmentedViewHandler?
    private let selectedLineView = UIView()
    private var selectedLineViewCenterXAnchor: NSLayoutConstraint?
    private var selectedLineViewWidthAnchor: NSLayoutConstraint?
    private var controllers: [UIViewController]?

    private var offsetToken: NSKeyValueObservation?

    private var scrollView: UIScrollView? {
        didSet {
            guard let scrollView = scrollView else { return }
            offsetToken = scrollView.observe(\.contentOffset) { [weak self] (scrollView, _) in
                guard let self = self else { return }
                guard let itemTitles = self.itemTitles, let segmentButtons = self.segmentButtons else { return }
                let contentOffset = scrollView.contentOffset
                self.selectedLineViewCenterXAnchor?.isActive = false
                let constant = (scrollView.frame.size.width / CGFloat(itemTitles.count * 2)) * CGFloat(((contentOffset.x / scrollView.frame.width) * 2) + 1)
                self.selectedLineViewCenterXAnchor = self.selectedLineView.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: constant)
                self.selectedLineViewCenterXAnchor?.isActive = true
                
                let index = Int(constant / (scrollView.frame.width / CGFloat(itemTitles.count)))
                guard index != self.selectedIndex else { return }
                self.selectedIndex = index
                
                if self.indicatorSizeFitTitleWidth {
                    let button = segmentButtons[index]
                    guard let string = button.titleLabel?.text else { fatalError("missing title on button, title is required for width calculation") }
                    guard let font = button.titleLabel?.font else { fatalError("missing dont on button, title is required for width calculation") }
                    let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
                    self.selectedLineViewWidthAnchor?.isActive = false
                    self.selectedLineViewWidthAnchor = self.selectedLineView.widthAnchor.constraint(equalToConstant: size.width)
                    self.selectedLineViewWidthAnchor?.isActive = true
                }
                self.segmentViewAction?(index)
            }
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
        }
    }

}

extension TabPage {
    
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
    
    private func setupControllers() {
        guard let scrollView = scrollView, let controllers = controllers else { return }
        let bgView = UIView()
        scrollView.addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        bgView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        let widthConstraint = bgView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        widthConstraint.priority = UILayoutPriority(rawValue: 750)
        widthConstraint.isActive = true
        bgView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        for i in 0 ..< controllers.count {
            guard let view = controllers[i].view else { return }
            view.translatesAutoresizingMaskIntoConstraints = false
            view.tag = i + 1
            bgView.addSubview(view)
            view.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            if i == 0 {
                view.leftAnchor.constraint(equalTo: bgView.leftAnchor).isActive = true
            } else {
                let preview = bgView.viewWithTag(i)!
                view.leftAnchor.constraint(equalTo: preview.rightAnchor).isActive = true
                view.widthAnchor.constraint(equalTo: preview.widthAnchor).isActive = true
            }
            if i == controllers.count - 1 {
                view.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
            }
        }
    }

    @objc private func appNavigationButtonAction(_ sender: UIButton) {
        selectedIndex = sender.tag - 1
        if let scrollView = scrollView {
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(selectedIndex)
            scrollView.scrollRectToVisible(frame, animated: true)
        } else {
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                self.scrollSelectedLineToIndex(index: self.selectedIndex)
                self.layoutSubviews()
            }, completion: nil)
            segmentViewAction?(selectedIndex)
        }

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
    
}
