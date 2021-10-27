//
//  MovieRepository.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    
    init()
    init(movieService: MovieServiceProtocol)
    
    func fetchNowPlaying() -> AnyPublisher<MovieListModel.MovieListResponse, Error>
    func fetchMovies(page: Int) -> AnyPublisher<MovieListModel.MovieListResponse, Error>
    func fetchMovie(id: Int) -> AnyPublisher<MovieModel.MovieEntity, Error>
    func saveMovie(movie: MovieModel.MovieEntity)
}

class MovieRepository: MovieRepositoryProtocol {
    private var movieService: MovieServiceProtocol
    
    required init() {
        movieService = MovieService()
    }
    
    required init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    func fetchNowPlaying() -> AnyPublisher<MovieListModel.MovieListResponse, Error> {
        movieService.fetchNowPlaying()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(page: Int = 1) -> AnyPublisher<MovieListModel.MovieListResponse, Error> {
        movieService.fetchMovies(page: page)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMovie(id: Int) -> AnyPublisher<MovieModel.MovieEntity, Error> {
        if let movie = fetchCacheMovie(id: id) {
            return Just(movie)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return movieService.fetchMovie(id: id)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    private func fetchCacheMovie(id: Int) -> MovieModel.MovieEntity? {
        return DataStore.movies[id]
    }
    
    func saveMovie(movie: MovieModel.MovieEntity) {
        guard let movieId = movie.id else { return }
        
        DataStore.movies.updateValue(movie, forKey: movieId)
    }
}
