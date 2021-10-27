//
//  MovieCellInteractor.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieCellInteractorProtocol {
    init(presenter: MovieCellPresenterProtocol, repository: MovieRepositoryProtocol)
    func configure(with movie: MovieListModel.MovieListEntity)
}

class MovieCellInteractor: MovieCellInteractorProtocol {
    private var presenter: MovieCellPresenterProtocol
    private var movieRepository: MovieRepositoryProtocol
    
    private var combineCancellable = Set<AnyCancellable>()
    
    required init(presenter: MovieCellPresenterProtocol, repository: MovieRepositoryProtocol) {
        self.presenter = presenter
        self.movieRepository = repository
    }
    
    func configure(with movie: MovieListModel.MovieListEntity) {
        guard let movieId = movie.id else { return }
        presenter.update(with: movie)
        
        // Fetch movie detail for each received to get duration time
        fetchMovie(id: movieId)
    }
    
    private func fetchMovie(id: Int) {
        movieRepository.fetchMovie(id: id)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] movie in
                guard let self = self else {
                    return
                }
                
                self.movieRepository.saveMovie(movie: movie)
                
                if let runtime = movie.runtime, let voteAverage = movie.voteAverage {
                    let duration = AppUtils.convertToTimeString(totalTime: runtime)
                    let rating = self.calculateRating(voteAverage: voteAverage)
                    self.presenter.updateMovieDetail(duration: duration, rating: rating)
                }
            }
            .store(in: &combineCancellable)
    }
    
    private func calculateRating(voteAverage: Double) -> Double {
        return voteAverage * 10
    }
}
