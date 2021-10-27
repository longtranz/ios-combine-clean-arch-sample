//
//  MovieCellPresenter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieCellPresenterProtocol {
    var viewModel: MovieListModel.MovieViewModel? { get }
    
    init(cell: MovieCellProtocol?)
    func update(with movieViewModel: MovieListModel.MovieListEntity)
    func updateMovieDetail(duration: String, rating: Double)
}

class MovieCellPresenter: MovieCellPresenterProtocol {
    private var cell: MovieCellProtocol?
    
    var viewModel: MovieListModel.MovieViewModel?
    
    private var combineCancellable = Set<AnyCancellable>()
    
    required init(cell: MovieCellProtocol?) {
        self.cell = cell
    }
    
    func update(with movie: MovieListModel.MovieListEntity) {
        viewModel = MovieListModel.MovieViewModel(from: movie)

        guard let movieViewModel = viewModel else { return }
        
        if let posterPath = movie.posterPath {
            movieViewModel.posterPath = String(format: "%@/w92%@", AppConstants.API.ImageHost, posterPath)
        }
        
        cell?.setupData(movie: movieViewModel)
        
        self.setupDataTrigger()
    }
    
    func updateMovieDetail(duration: String, rating: Double) {
        viewModel?.duration = duration
        viewModel?.rating = rating
    }
    
    private func setupDataTrigger() {
        combineCancellable.forEach { cancellable in
            cancellable.cancel()
        }
        
        viewModel?.$duration
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self,
                      let duration = value else { return }
                self.cell?.updateDuration(duration: duration)
            })
            .store(in: &combineCancellable)
    }
}
