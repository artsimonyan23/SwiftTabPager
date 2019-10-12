//
//  AppNavigationSegmentView.swift
//  FellowTime
//
//  Created by ArtS on 4/23/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit

// public final class TabPageCollectionView: UICollectionView {
//
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//
//        setupCollectionView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        setupCollectionView()
//    }
//
//    private init() {
//        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
//    }
//
//    private lazy var layout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        return layout
//    }()
//
//    private func setupCollectionView() {
//        isPagingEnabled = true
//        collectionViewLayout = layout
//        showsHorizontalScrollIndicator = false
//        showsVerticalScrollIndicator = false
//    }
//
////    override var collectionViewLayout: UICollectionViewLayout {
////        set { }
////        get {
////            return layout
////        }
////    }
//
////    override var delegate: UICollectionViewDelegate? {
////        didSet {
////            if oldValue is AppNavigationSegmentView {
////                delegate = oldValue
////            }
////        }
////    }
////
////    override var dataSource: UICollectionViewDataSource? {
////        didSet {
////            if oldValue is AppNavigationSegmentView {
////                dataSource = oldValue
////            }
////        }
////    }
//
// }

// final class AppNewNavigationCollectionView: UICollectionView {
//
////    var segmentedLayoutItem: AppNavigationSegmentView.SegmentedLayoutItem? = IBPNSCollectionLayoutItem(layoutSize: IBPNSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(100)))
//
//    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
//        super.init(frame: frame, collectionViewLayout: layout)
//
//        setupCollectionView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        setupCollectionView()
//    }
//
////    private init() {
////        super.init(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
////    }
////
////    private lazy var layout: UICollectionViewLayout = {
////        return UICollectionViewCompositionalLayout { sectionNumber, env -> NSCollectionLayoutSection? in
//////            guard let segmentedLayoutItem = self.segmentedLayoutItem else { return nil }
////            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
////                                                   heightDimension: .fractionalHeight(1))
////            let group = NSCollectionLayoutGroup(layoutSize: groupSize)
////            let section = NSCollectionLayoutSection(group: group)
////
////            section.orthogonalScrollingBehavior = .groupPaging
////            return section
////        }
////    }()
//
//    private func setupCollectionView() {
//        isPagingEnabled = true
////        collectionViewLayout = layout
//        showsHorizontalScrollIndicator = false
//        showsVerticalScrollIndicator = false
//    }
//
////    override var collectionViewLayout: UICollectionViewLayout {
////        set { }
////        get {
////            return layout
////        }
////    }
//
////    override var delegate: UICollectionViewDelegate? {
////        didSet {
////            if oldValue is AppNavigationSegmentView {
////                delegate = oldValue
////            }
////        }
////    }
////
////    override var dataSource: UICollectionViewDataSource? {
////        didSet {
////            if oldValue is AppNavigationSegmentView {
////                dataSource = oldValue
////            }
////        }
////    }
//
// }
