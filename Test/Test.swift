//
//  Test.swift
//  SwiftTabPager
//
//  Created by ArtS on 10/12/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import Foundation

// extension TabPage {
//
//    public typealias SegmentedViewHandlerCell = ((_ selectedIndexPath: IndexPath) -> UICollectionViewCell)
//    typealias SegmentedLayoutSection = ((_ section: Int) -> NSCollectionLayoutSection)
// private var segmentViewCellAction: SegmentedViewHandlerCell?
// private var scrollOffsetInfoArray = [Int: [(scrollView: UIScrollView, offset: CGPoint)]]()
// @IBInspectable public var fixContainedScrollOffset: Bool = false

// private var collectionView: TabPageCollectionView? {
//    didSet {
//        guard let collectionView = collectionView else { return }
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    }
// }
// private var newCollectionView: AppNewNavigationCollectionView? {
//    didSet {
//        guard let collectionView = collectionView else { return }
//        collectionView.dataSource = self
//        collectionView.delegate = self
//    }
// }
//
// private var scrollView: TabBarScrollView? {
//    didSet {
//        guard let scrollView = scrollView else { return }
//        scrollView.delegate = self
//    }
// }
//            public func setTitles(titles: [String], completion: @escaping SegmentedViewHandler) {
//                itemTitles = titles.filter({!$0.isEmpty})
//                segmentViewAction = completion
//            }

// private var controllers: [UIViewController]?
//
// private func findScrollView(subviews: [UIView]) -> [UIScrollView] {
//    var collection = [UIScrollView]()
//    subviews.forEach { (view) in
//        if view is UIScrollView {
//            collection.append(view as! UIScrollView)
//        }
//        collection += findScrollView(subviews: view.subviews)
//    }
//    return collection
// }
//
//            public func setWithCollectionView(collectionView: TabPageCollectionView, titles: [String], completion: @escaping SegmentedViewHandlerCell) {
//                itemTitles = titles.filter({!$0.isEmpty})
//                segmentViewCellAction = completion
//                self.collectionView = collectionView
//            }
//
//        //    func setNewWithCollectionView(collectionView: AppNewNavigationCollectionView, layoutSection: @escaping SegmentedLayoutSection, titles: [String], completion: @escaping SegmentedViewHandler) {
//        //        itemTitles = titles.filter({!$0.isEmpty})
//        //        self.newCollectionView = collectionView
//        ////        collectionView.numberOfSectionsIn { () -> Int in
//        ////            return titles.count
//        ////        }
//        //        collectionView.didScroll { (scroll) in
//        //            self.scrollViewDidScroll(scroll)
//        //        }
//        //        segmentViewAction = completion
//        //
//        //        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
//        //            return layoutSection(sectionIndex)
//        //        }
//        //        let config = UICollectionViewCompositionalLayoutConfiguration()
//        //        config.scrollDirection = .horizontal
//        //        layout.configuration = config
//        //        collectionView.collectionViewLayout = layout
//        //    }
//
//            public func setWithControllersOn(scrollView: TabBarScrollView, data: [(title: String, controller: UIViewController)], completion: @escaping SegmentedViewHandler) {
//                itemTitles = data.compactMap({$0.title})
//                segmentViewAction = completion
//                self.scrollView = scrollView
//                self.controllers = data.compactMap({$0.controller})
//                setupControllers()
//            }
//
//            private func setupControllers() {
//                guard let scrollView = scrollView, let controllers = controllers else { return }
//                let bgView = UIView()
//                scrollView.addSubview(bgView)
//                bgView.backgroundColor = .yellow
//                bgView.translatesAutoresizingMaskIntoConstraints = false
//                bgView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
//                bgView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
//                bgView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
//                bgView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
//                let widthConstraint = bgView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//                widthConstraint.priority = UILayoutPriority(rawValue: 750)
//                widthConstraint.isActive = true
//                bgView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
//                for i in 0 ..< controllers.count {
//        //            scrollView.parentContainerViewController()?.addChild(controllers[i])
//        //            controllers[i].didMove(toParent: scrollView.parentContainerViewController())
//                    let view = controllers[i].view!
//                    view.translatesAutoresizingMaskIntoConstraints = false
//                    view.tag = i + 1
//                    bgView.addSubview(view)
//                    view.topAnchor.constraint(equalTo: bgView.topAnchor).isActive = true
//                    view.bottomAnchor.constraint(equalTo: bgView.bottomAnchor).isActive = true
//                    view.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//                    if i == 0 {
//                        view.leftAnchor.constraint(equalTo: bgView.leftAnchor).isActive = true
//                    } else {
//                        let preview = bgView.viewWithTag(i)!
//                        view.leftAnchor.constraint(equalTo: preview.rightAnchor).isActive = true
//                        view.widthAnchor.constraint(equalTo: preview.widthAnchor).isActive = true
//                    }
//                    if i == controllers.count - 1 {
//                        view.rightAnchor.constraint(equalTo: bgView.rightAnchor).isActive = true
//                    }
//                }
//            }

// @objc private func appNavigationButtonAction(_ sender: UIButton) {
//    let index = sender.tag - 1
//    if let collectionView = collectionView {
//        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
//    } else if let newCollectionView = newCollectionView {
//        newCollectionView.setContentOffset(CGPoint(x: CGFloat(index) * newCollectionView.frame.width, y: 0), animated: true)
//    } else if let scrollView = scrollView {
//        var frame = scrollView.bounds
//        frame.origin.x = frame.size.width * CGFloat(index)
//        scrollView.scrollRectToVisible(frame, animated: true)
//    } else {
//        selectedIndex = index
//        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
//            self.scrollSelectedLineToIndex(index: self.selectedIndex)
//            self.layoutSubviews()
//        }, completion: nil)
//        segmentViewAction?(index)
//    }
// }
// }

// extension TabPage: UICollectionViewDataSource {
//
//    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return itemTitles?.count ?? 0
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = segmentViewCellAction!(indexPath)
//
//        if fixContainedScrollOffset {
//            if scrollOffsetInfoArray[indexPath.row] == nil {
//                scrollOffsetInfoArray[indexPath.row] = [(scrollView: UIScrollView, offset: CGPoint)]()
//                findScrollView(subviews: cell.subviews).forEach { (scrollView) in
//                    scrollOffsetInfoArray[indexPath.row]?.append((scrollView: scrollView, offset: CGPoint.zero))
//                }
//            }
//        }
//        return cell
//    }
// }
//
// extension TabPage: UICollectionViewDelegate {
//
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
//        if indicatorSizeMatchesTitle {
//            let button = segmentButtons[index]
//            guard let string = button.titleLabel?.text else { fatalError("missing title on button, title is required for width calculation") }
//            guard let font = button.titleLabel?.font else { fatalError("missing dont on button, title is required for width calculation") }
//            let size = string.size(withAttributes: [NSAttributedString.Key.font: font])
//            selectedLineViewWidthAnchor?.isActive = false
//            selectedLineViewWidthAnchor = selectedLineView.widthAnchor.constraint(equalToConstant: size.width)
//            selectedLineViewWidthAnchor?.isActive = true
//        }
//        segmentViewAction?(index)
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if fixContainedScrollOffset {
//            for i in 0..<(scrollOffsetInfoArray[indexPath.row]?.count ?? 0) {
//                self.scrollOffsetInfoArray[indexPath.row]![i].scrollView.contentOffset = self.scrollOffsetInfoArray[indexPath.row]![i].offset
//            }
//        }
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if fixContainedScrollOffset {
//            for i in 0..<(scrollOffsetInfoArray[indexPath.row]?.count ?? 0) {
//                scrollOffsetInfoArray[indexPath.row]![i].offset = scrollOffsetInfoArray[indexPath.row]![i].scrollView.contentOffset
//                scrollOffsetInfoArray[indexPath.row]![i].scrollView.contentOffset = CGPoint.zero
//            }
//        }
//    }
//
// }
//
//
// extension TabPage: UICollectionViewDelegateFlowLayout {
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return collectionView.frame.size
//    }
//
//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
// }
//
