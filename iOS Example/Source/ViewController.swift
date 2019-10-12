//
//  ViewController.swift
//  iOS Example
//
//  Created by Arthur Simonyan on Oct 10, 2019.
//  Copyright © 2019 ArtS. All rights reserved.
//

import SwiftTabPager
import UIKit

class ViewController: UIViewController {

    @IBOutlet var tabPagesCollection: [TabPage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabPagesCollection.forEach { (tabPage) in
            tabPage.setTitles(titles: ["Title 1", "2", "Three", "4"]) { selectedIndex in
                print(selectedIndex)
            }
        }

    }
}
