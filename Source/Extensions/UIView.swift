//
//  UIView.swift
//  SwiftTabPager
//
//  Created by ArtS on 11/25/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit

extension UIView {
    func viewContainingController() -> UIViewController? {
        var nextResponder: UIResponder? = self

        repeat {
            nextResponder = nextResponder?.next

            if let viewController = nextResponder as? UIViewController {
                return viewController
            }

        } while nextResponder != nil

        return nil
    }
}
