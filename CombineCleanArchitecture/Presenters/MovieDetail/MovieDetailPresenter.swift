//
//  MovieDetailPresenter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    var viewModel: MovieModel.MovieViewModel? { get }
    
    func updateMovie(with movie: MovieModel.MovieEntity)
    
    init(view: MovieDetailViewControllerProtocol?)
}

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    private var view: MovieDetailViewControllerProtocol?
    
    var viewModel: MovieModel.MovieViewModel?
    
    required init(view: MovieDetailViewControllerProtocol?) {
        self.view = view
    }
    
    func updateMovie(with movie: MovieModel.MovieEntity) {
        viewModel = MovieModel.MovieViewModel(from: movie)
        
        guard let vm = viewModel else { return }
        
        if let totalTime = movie.runtime {
            vm.duration = AppUtils.convertToTimeString(totalTime: totalTime)
        }
        
        if let posterPath = movie.posterPath {
            vm.posterPath = String(format: "%@/w154%@", AppConstants.API.ImageHost, posterPath)
        }
        
        view?.updateView(with: vm)
    }
}
