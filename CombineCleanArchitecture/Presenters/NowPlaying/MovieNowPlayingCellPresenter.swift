//
//  MovieNowPlayingCellPresenter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit
import Combine

protocol MovieNowPlayingCellPresenterProtocol {
    init(view: NowPlayingCellProtocol?)
    func updateMovie(movie: MovieListModel.MovieListEntity)
}

class MovieNowPlayingCellPresenter: MovieNowPlayingCellPresenterProtocol {
    private var viewModel: MovieListModel.MovieViewModel?
    private var view: NowPlayingCellProtocol?
    
    required init(view: NowPlayingCellProtocol?) {
        self.view = view
    }
    
    func updateMovie(movie: MovieListModel.MovieListEntity) {
        viewModel = MovieListModel.MovieViewModel(from: movie)
        
        if let vm = viewModel {
            if let posterPath = movie.posterPath {
                vm.posterPath = String(format: "%@/w154%@", AppConstants.API.ImageHost, posterPath)
            }
            
            self.view?.updateMovie(with: vm)
        }
    }
}
