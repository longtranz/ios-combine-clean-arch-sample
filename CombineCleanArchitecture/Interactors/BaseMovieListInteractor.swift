//
//  BaseMovieListInteractor.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol BaseMovieListInteractorProtocol {
    var moviesPublisher: Published<[MovieListModel.MovieListEntity]>.Publisher { get }
    
    var movies: [MovieListModel.MovieListEntity] { get }
    
    func refreshMovies()
    func fetchMovies(page: Int)
    func getMovieAt(_ index: Int) -> MovieListModel.MovieListEntity
}
