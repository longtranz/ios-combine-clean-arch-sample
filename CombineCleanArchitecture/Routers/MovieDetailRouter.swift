//
//  MovieDetailRouter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol: BaseRouterProtocol {
    func onClose()
}

class MovieDetailRouter: MovieDetailRouterProtocol {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func onClose() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
