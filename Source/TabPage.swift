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

    @IBInspectable public var selectedBorderWidth: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var selectedBorderCornerRadius: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var selectedBorderColor: UIColor = .black { didSet { createButtons() } }
    
    @IBInspectable public var selectedTextFont: UIFont? { didSet { createButtons() } }

    @IBInspectable public var unselectedTextColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2) { didSet { createButtons() } }

    @IBInspectable public var unselectedBackgroundColor: UIColor = .white { didSet { createButtons() } }
    
    @IBInspectable public var unselectedBorderWidth: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var unselectedBorderCornerRadius: CGFloat = 0 { didSet { createButtons() } }

    @IBInspectable public var unselectedBorderColor: UIColor = .black { didSet { createButtons() } }
    
    @IBInspectable public var unselectedTextFont: UIFont? { didSet { createButtons() } }
    
    @IBInspectable public var indicatorColor: UIColor = UIColor.black {
        didSet {
            createSelectedLine()
            guard let selectedLineView = selectedLineView else { return }
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorIsAtBottom: Bool = true {
        didSet {
            createSelectedLine()
            guard let selectedLineView = selectedLineView else { return }
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorSizeFitTitleWidth: Bool = false {
        didSet {
            createSelectedLine()
            guard let selectedLineView = selectedLineView else { return }
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorHeight: CGFloat = 1.0 {
        didSet {
            createSelectedLine()
            guard let selectedLineView = selectedLineView else { return }
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorWidth: CGFloat = -1 {
        didSet {
            createSelectedLine()
            guard let selectedLineView = selectedLineView else { return }
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }

    @IBInspectable public var indicatorOffset: CGFloat = 0 {
        didSet {
            createSelectedLine()
            guard let selectedLineView = selectedLineView else { return }
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

    @IBInspectable public var animationDuration: Double = 0.2

    public typealias SegmentedViewHandler = ((_ selectedIndex: Int) -> Void)
    public typealias SegmentedViewHandlerCell = ((_ selectedIndexPath: IndexPath) -> UICollectionViewCell)

    public var segmentButtons: [UIButton]?

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setWithTitles(titles: ["One", "Two", "Three"]) { _ in }
    }

    public func setWithTitles(titles: [String], completion: @escaping SegmentedViewHandler) {
        itemTitles = titles.filter({ !$0.isEmpty })
        segmentViewAction = completion
    }
    
    public func setWithControllers(data: [(title: String, controller: UIViewController)], on scrollView: UIScrollView, completion: @escaping SegmentedViewHandler) {
        itemTitles = data.compactMap({$0.title})
        segmentViewAction = completion
        self.scrollView = scrollView
        self.childControllers = data.compactMap({$0.controller})
        setupPages(views: data.compactMap({$0.controller.view}), on: scrollView)
    }
    
    public func setWithControllers(data: [(title: String, controller: UIViewController)], on scrollView: UIScrollView, delegate: TabPageDelegate) {
        self.tabPageDelegate = delegate
        setWithControllers(data: data, on: scrollView) { (index) in
            self.tabPageDelegate?.tabPage(didSelectAt: index)
        }
    }
    
    public func setWithViews(data: [(title: String, view: UIView)], on scrollView: UIScrollView, completion: @escaping SegmentedViewHandler) {
        itemTitles = data.compactMap({$0.title})
        segmentViewAction = completion
        self.scrollView = scrollView
        setupPages(views: data.compactMap({$0.view}), on: scrollView)
    }
    
    public func setWithViews(data: [(title: String, view: UIView)], on scrollView: UIScrollView, delegate: TabPageDelegate) {
        self.tabPageDelegate = delegate
        setWithViews(data: data, on: scrollView) { (index) in
            self.tabPageDelegate?.tabPage(didSelectAt: index)
        }
    }
    
    public func setWithCollectionViewCells(data: [(title: String, cell: UICollectionViewCell)], on collectionView: UICollectionView, completion: @escaping SegmentedViewHandler) {
        itemTitles = data.map({$0.title})
        self.collectionView = collectionView
        collectionCells = data.map({$0.cell})
        segmentViewAction = completion
    }
    
    public func setWithCollectionViewCells(data: [(title: String, cell: UICollectionViewCell)], on collectionView: UICollectionView, delegate: TabPageDelegate) {
        self.tabPageDelegate = delegate
        setWithCollectionViewCells(data: data, on: collectionView) { (index) in
            self.tabPageDelegate?.tabPage(didSelectAt: index)
        }
    }
    
    public override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            offsetToken?.invalidate()
        }
    }
    
    
    // private properties
    
    private weak var tabPageDelegate: TabPageDelegate?
    
    private var itemTitles: [String]? {
        didSet {
            createButtons()
            createSelectedLine()
            //                layoutIfNeeded()
            guard let selectedLineView = selectedLineView else { return }
            selectedLineView.layoutIfNeeded()
            scrollSelectedLineToIndex(index: 0)
        }
    }
    
    private var collectionCells: [UICollectionViewCell]?

    private var selectedIndex = 0 {
        willSet {
            guard segmentButtons?.count ?? 0 > newValue, newValue >= 0 else { return }
            if let button = segmentButtons?[newValue] {
                button.isEnabled = false
            }
        }
        didSet {
            if selectedIndex != oldValue {
                self.segmentViewAction?(selectedIndex)
            }
            guard segmentButtons?.count ?? 0 > oldValue, oldValue >= 0 else { return }
            if let previewButton = segmentButtons?[oldValue] {
                previewButton.isEnabled = true
            }
        }
    }

    private var segmentViewAction: SegmentedViewHandler?
    private var selectedLineView: UIView?
    private var selectedLineViewCenterXAnchor: NSLayoutConstraint?
    private var selectedLineViewWidthAnchor: NSLayoutConstraint?

    private var offsetToken: NSKeyValueObservation?

    private var childControllers: [UIViewController]? {
        didSet {
            oldValue?.forEach({ (controller) in
                controller.removeFromParent()
            })
            childControllers?.forEach { controller in
                viewContainingController()?.addChild(controller)
            }
        }
    }

    private var scrollView: UIScrollView? {
        didSet {
            offsetToken?.invalidate()
            setupScrollView()
        }
    }
    
    private var collectionView: UICollectionView? {
        didSet {
            offsetToken?.invalidate()
            setupCollectionView()
        }
    }

}

extension TabPage {
    
    private func createButtons() {
        guard let itemTitles = itemTitles else { return }
        segmentButtons = []
        for i in 0 ..< itemTitles.count {
            let button = TabButton()
            addSubview(button)
            segmentButtons?.append(button)
            button.selectedTextColor = selectedTextColor
            button.selectedBackgroundColor = selectedBackgroundColor
            button.selectedBorderWidth = selectedBorderWidth
            button.selectedBorderCornerRadius = selectedBorderCornerRadius
            button.selectedBorderColor = selectedBorderColor
            button.selectedTextFont = selectedTextFont
            button.unselectedTextColor = unselectedTextColor
            button.unselectedBackgroundColor = unselectedBackgroundColor
            button.unselectedBorderWidth = unselectedBorderWidth
            button.unselectedBorderCornerRadius = unselectedBorderCornerRadius
            button.unselectedBorderColor = unselectedBorderColor
            button.unselectedTextFont = unselectedTextFont
            button.tag = i + 1
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
        }
    }

    private func createSelectedLine() {
        selectedLineView?.removeFromSuperview()
        selectedLineView = nil
        guard let itemTitles = itemTitles, itemTitles.count > 0, indicatorColor != .clear, let button = segmentButtons?.first else { return }
        selectedLineView = UIView()
        let selectedLineView = self.selectedLineView!
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
    
    private func setupScrollView() {
        guard let scrollView = scrollView else { return }
        offsetToken = scrollView.observe(\.contentOffset) { [weak self] (scrollView, _) in
            guard let self = self else { return }
            guard let itemTitles = self.itemTitles, let segmentButtons = self.segmentButtons else { return }
            let contentOffset = scrollView.contentOffset
            let constant = (scrollView.frame.size.width / CGFloat(itemTitles.count * 2)) * CGFloat(((contentOffset.x / scrollView.frame.width) * 2) + 1)
            if let selectedLineView = self.selectedLineView {
                self.selectedLineViewCenterXAnchor?.isActive = false
                self.selectedLineViewCenterXAnchor = selectedLineView.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: constant)
                self.selectedLineViewCenterXAnchor?.isActive = true
            }
            let index = Int(constant / (scrollView.frame.width / CGFloat(itemTitles.count)))
            guard index != self.selectedIndex else { return }
            if scrollView.isDecelerating || scrollView.isDragging {
                self.selectedIndex = index
            }
            if self.indicatorSizeFitTitleWidth {
                let button = segmentButtons[index]
                guard let string = button.titleLabel?.text else { fatalError("missing title on button, title is required for width calculation") }
                guard let font = button.titleLabel?.font else { fatalError("missing dont on button, title is required for width calculation") }
                let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
                if let selectedLineView = self.selectedLineView {
                    self.selectedLineViewWidthAnchor?.isActive = false
                    self.selectedLineViewWidthAnchor = selectedLineView.widthAnchor.constraint(equalToConstant: size.width)
                    self.selectedLineViewWidthAnchor?.isActive = true
                }
            }
        }
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupCollectionView() {
        guard let collectionView = collectionView else { return }
        offsetToken = collectionView.observe(\.contentOffset) { [weak self] (scrollView, _) in
            guard let self = self else { return }
            guard let itemTitles = self.itemTitles, let segmentButtons = self.segmentButtons else { return }
            let contentOffset = scrollView.contentOffset
            let constant = (scrollView.frame.size.width / CGFloat(itemTitles.count * 2)) * CGFloat(((contentOffset.x / scrollView.frame.width) * 2) + 1)
            if let selectedLineView = self.selectedLineView {
                self.selectedLineViewCenterXAnchor?.isActive = false
                self.selectedLineViewCenterXAnchor = selectedLineView.centerXAnchor.constraint(equalTo: scrollView.leftAnchor, constant: constant)
                self.selectedLineViewCenterXAnchor?.isActive = true
            }
            let index = Int(constant / (scrollView.frame.width / CGFloat(itemTitles.count)))
            guard index != self.selectedIndex else { return }
            if scrollView.isDecelerating || scrollView.isDragging {
                self.selectedIndex = index
            }
            if self.indicatorSizeFitTitleWidth {
                let button = segmentButtons[index]
                guard let string = button.titleLabel?.text else { fatalError("missing title on button, title is required for width calculation") }
                guard let font = button.titleLabel?.font else { fatalError("missing dont on button, title is required for width calculation") }
                let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
                if let selectedLineView = self.selectedLineView {
                    self.selectedLineViewWidthAnchor?.isActive = false
                    self.selectedLineViewWidthAnchor = selectedLineView.widthAnchor.constraint(equalToConstant: size.width)
                    self.selectedLineViewWidthAnchor?.isActive = true
                }
            }
        }
        collectionView.isPagingEnabled = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupPages(views: [UIView], on scrollView: UIScrollView) {
        scrollView.viewWithTag(123)?.removeFromSuperview()
        let bgView = UIView()
        bgView.tag = 123
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
        for i in 0 ..< views.count {
            let view = views[i]
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
            if i == views.count - 1 {
                view.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
            }
        }
    }

    private func scrollSelectedLineToIndex(index: Int) {
        guard let selectedLineView = selectedLineView else { return }
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

extension TabPage: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemTitles?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionCells?[indexPath.row] ?? UICollectionViewCell()
    }
    
}

extension TabPage: UICollectionViewDelegate {
    
//    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        guard let itemTitles = itemTitles, let segmentButtons = segmentButtons else { return }
//        
//        selectedLineViewCenterXAnchor?.isActive = false
//        let constant = (frame.size.width / CGFloat(itemTitles.count * 2)) * CGFloat(((scrollView.contentOffset.x / frame.width) * 2) + 1)
//        selectedLineViewCenterXAnchor = selectedLineView.centerXAnchor.constraint(equalTo: leftAnchor, constant: constant)
//        selectedLineViewCenterXAnchor?.isActive = true
//        
//        let index = Int(constant / (frame.width / CGFloat(itemTitles.count)))
//        guard index != selectedIndex else { return }
//        selectedIndex = index
//        
//        if indicatorSizeFitTitleWidth {
//            let button = segmentButtons[index]
//            guard let string = button.titleLabel?.text else { fatalError("missing title on button, title is required for width calculation") }
//            guard let font = button.titleLabel?.font else { fatalError("missing dont on button, title is required for width calculation") }
//            let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
//            selectedLineViewWidthAnchor?.isActive = false
//            selectedLineViewWidthAnchor = selectedLineView?.widthAnchor.constraint(equalToConstant: size.width)
//            selectedLineViewWidthAnchor?.isActive = true
//        }
//        segmentViewAction?(index)
//    }
    
}

extension TabPage: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

