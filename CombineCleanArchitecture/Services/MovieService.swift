//
//  MovieService.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func fetchNowPlaying() -> AnyPublisher<MovieListModel.MovieListResponse, Error>
    func fetchMovies(page: Int) -> AnyPublisher<MovieListModel.MovieListResponse, Error>
    func fetchMovie(id: Int) -> AnyPublisher<MovieModel.MovieEntity, Error>
}

class MovieService: MovieServiceProtocol {
    let defaultSession = URLSession(configuration: .default)
    
    func fetchNowPlaying() -> AnyPublisher<MovieListModel.MovieListResponse, Error> {
        let movieListRequest = MovieListModel.MovieListRequest(.nowPlaying)
        guard let url = movieListRequest.url() else {
            return AnyPublisher(Fail<MovieListModel.MovieListResponse, Error>(error: URLError(.badURL)))
        }
        
        return defaultSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> MovieListModel.MovieListResponse in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.MovieListResponse.self, from: data)
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(page: Int) -> AnyPublisher<MovieListModel.MovieListResponse, Error> {
        let movieListRequest = MovieListModel.MovieListRequest(.popular, page: page)
        guard let url = movieListRequest.url() else {
            return AnyPublisher(Fail<MovieListModel.MovieListResponse, Error>(error: URLError(.badURL)))
        }
        
        return defaultSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> MovieListModel.MovieListResponse in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.MovieListResponse.self, from: data)
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMovie(id: Int) -> AnyPublisher<MovieModel.MovieEntity, Error> {
        let movieRequest = MovieModel.MovieRequest(id: id)
        guard let url = movieRequest.url() else {
            return AnyPublisher(Fail<MovieModel.MovieEntity, Error>(error: URLError(.badURL)))
        }
                
        return defaultSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> MovieModel.MovieEntity in
                let decoder = JSONDecoder()
                let movie = try decoder.decode(MovieModel.MovieEntity.self, from: data)
                
                return movie
            })
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
