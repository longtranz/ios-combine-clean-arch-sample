//
//  MovieListRouter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListRouterProtocol: BaseRouterProtocol {
    func showMovie(id: Int)
}

class MovieListRouter: MovieListRouterProtocol {
    var viewController: UIViewController
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func showMovie(id: Int) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let movieDetailViewController = mainStoryboard.instantiateViewController(identifier: "MovieDetailViewController") as MovieDetailViewController
        movieDetailViewController.modalPresentationStyle = .overCurrentContext
        movieDetailViewController.setupMovie(id: id)
        viewController.present(movieDetailViewController, animated: true, completion: nil)
    }
}
