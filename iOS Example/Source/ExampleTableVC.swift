//
//  ExampleTableVC.swift
//  iOS Example
//
//  Created by ArtS on 11/25/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import SwiftTabPager
import UIKit

class ExampleTableVC: UITableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScrollVCId") as! ScrollVC
        vc.setupTabPage = { tabPage, scrollView in
            if indexPath.row == 1 {
                let vc1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "controllerVCId")
                let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "controllerVC2Id")

                tabPage.setWithControllers(data: [(title: "aaa", controller: vc1),
                                                  (title: "bbb", controller: vc2)],
                                           on: scrollView,
                                           delegate: self)

            } else if indexPath.row == 2 {
                let view1 = UIView()
                view1.backgroundColor = .red
                let view2 = UIView()
                view2.backgroundColor = .blue
                let view3 = UIView()
                view3.backgroundColor = .yellow

                tabPage.setWithViews(data: [(title: "aaa", view: view1),
                                            (title: "bbb", view: view2),
                                            (title: "ccc", view: view3)],
                                     on: scrollView) { selectedIndex in
                    print("selectedIndex with closure - \(selectedIndex)")
                }
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ExampleTableVC: TabPageDelegate {
    func tabPage(didSelectAt index: Int) {
        print("selectedIndex with delegate - \(index)")
    }
}
