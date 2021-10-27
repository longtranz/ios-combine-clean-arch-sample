//
//  MovieMockServices.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

class MovieMockService: MovieServiceProtocol {
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    
    func fetchNowPlaying() -> AnyPublisher<MovieListModel.MovieListResponse, Error> {
        guard let url = Bundle.main.url(forResource: "now_playing", withExtension: "json") else {
            return AnyPublisher(Fail<MovieListModel.MovieListResponse, Error>(error: URLError(.badURL)))
        }
        
        return defaultSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> MovieListModel.MovieListResponse in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.MovieListResponse.self, from: data)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMovies(page: Int) -> AnyPublisher<MovieListModel.MovieListResponse, Error> {
        guard let url = Bundle.main.url(forResource: "popular_\(page)", withExtension: "json") else {
            return AnyPublisher(Fail<MovieListModel.MovieListResponse, Error>(error: URLError(.badURL)))
        }
        
        return defaultSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> MovieListModel.MovieListResponse in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieListModel.MovieListResponse.self, from: data)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func fetchMovie(id: Int) -> AnyPublisher<MovieModel.MovieEntity, Error> {
        guard let url = Bundle.main.url(forResource: "\(id)", withExtension: "json") else {
            return AnyPublisher(Fail<MovieModel.MovieEntity, Error>(error: URLError(.badURL)))
        }
        
        return defaultSession.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> MovieModel.MovieEntity in
                let decoder = JSONDecoder()
                return try decoder.decode(MovieModel.MovieEntity.self, from: data)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
