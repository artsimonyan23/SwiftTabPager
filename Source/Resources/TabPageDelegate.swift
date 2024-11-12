//
//  TabPageDelegate.swift
//  SwiftTabPager
//
//  Created by ArtS on 11/25/19.
//  Copyright © 2019 ArtS. All rights reserved.
//

import UIKit

public protocol TabPageDelegate: NSObjectProtocol {
    func tabPage(didSelectAt index: Int)
}
