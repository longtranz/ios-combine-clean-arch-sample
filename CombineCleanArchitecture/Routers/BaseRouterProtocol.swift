//
//  BaseRouterProtocol.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRouterProtocol {
    var viewController: UIViewController { get }
    
    init(viewController: UIViewController)
}
