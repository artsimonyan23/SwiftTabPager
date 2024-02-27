//
//  TabPagesVC.swift
//  iOS Example
//
//  Created by Arthur Simonyan on Oct 10, 2019.
//  Copyright © 2019 ArtS. All rights reserved.
//

import SwiftTabPager
import UIKit

class TabPagesVC: UIViewController {
    @IBOutlet var tabPagesCollection: [TabPage]!

    override func viewDidLoad() {
        super.viewDidLoad()

        tabPagesCollection.forEach { tabPage in
            tabPage.setWithTitles(titles: ["Title 1", "2", "Three", "4"]) { selectedIndex in
                print(selectedIndex)
            }
        }
    }
}
