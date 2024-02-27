//
//  ScrollVC.swift
//  iOS Example
//
//  Created by ArtS on 10/29/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import SwiftTabPager
import UIKit

class ScrollVC: UIViewController {
    @IBOutlet weak var tabPage: TabPage!
    @IBOutlet weak var scrollView: UIScrollView!

    var setupTabPage: ((_ tabPage: TabPage, _ scrollView: UIScrollView) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabPage?(tabPage, scrollView)
    }
}
