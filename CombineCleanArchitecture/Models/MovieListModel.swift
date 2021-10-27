//
//  MovieListModel.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

struct MovieListModel {
    class MovieListRequest: BaseMovieRequest, Encodable {
        var page: Int
        
        init(_ requestType: AppConstants.API.RequestType, page: Int = 0, language: String = "en-us") {
            self.page = page
            
            super.init(requestType, language: language)
            
            params.updateValue(page > 0 ? String(page) : "undefined", forKey: "page")
        }
    }
    
    struct MovieListResponse: Codable {
        let dates: Dates?
        let page: Int?
        let results: [MovieListEntity]?
        let totalPages: Int?
        let totalResults: Int?

        enum CodingKeys: String, CodingKey {
            case dates
            case page
            case results
            case totalPages = "total_pages"
            case totalResults = "total_results"
        }
    }
    
    struct Dates: Codable {
        let maximum, minimum: String?
    }
    
    struct MovieListEntity: Codable {
        let adult: Bool?
        let backdropPath: String?
        let genreIDS: [Int]?
        let id: Int?
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let popularity: Double?
        let posterPath: String?
        let releaseDate, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    
    class MovieViewModel {
        var id: Int?
        var title: String?
        var posterPath: String?
        var rating: Double?
        var releaseDate: Date?        
        @Published var duration: String?
        
        init(from entity: MovieListEntity) {
            id = entity.id
            title = entity.title
            rating = entity.voteAverage
            posterPath = entity.posterPath
            if let rDate = entity.releaseDate {
                releaseDate = Date.fromString(rDate, format: AppConstants.DateFormat.YYYYMMDD_MINUS)
            }
        }
    }
}
