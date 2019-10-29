//
//  ViewController.swift
//  iOS Example
//
//  Created by ArtS on 10/29/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit
import SwiftTabPager

class ViewController: UIViewController {

    @IBOutlet weak var tabPage: TabPage!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .blue
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .yellow
        
        tabPage.setWithControllersOn(scrollView: scrollView, data: [(title: "aaa", controller: vc1),
                                                                    (title: "bbb", controller: vc2),
                                                                    (title: "ccc", controller: vc3)]) { (selectedIndex) in
            print(selectedIndex)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
