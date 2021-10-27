//
//  MovieModel.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

struct MovieModel {
    class MovieRequest: BaseMovieRequest, Encodable {
        var id: Int
        
        init(id: Int, language: String = "en-US") {
            self.id = id
            
            super.init(.detail(id: id), language: language)
        }
    }
    
    struct MovieEntity: Codable {
        let adult: Bool?
        let backdropPath: String?
        let belongsToCollection: CollectionEntity?
        let budget: Int?
        let genres: [GenreEntity]?
        let homepage: String?
        let id: Int?
        let imdbID, originalLanguage, originalTitle, overview: String?
        let popularity: Double?
        let posterPath: String?
        let productionCompanies: [ProductionCompanyEntity]?
        let productionCountries: [ProductionCountryEntity]?
        let releaseDate: String?
        let revenue, runtime: Int?
        let spokenLanguages: [SpokenLanguageEntity]?
        let status, tagline, title: String?
        let video: Bool?
        let voteAverage: Double?
        let voteCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case belongsToCollection = "belongs_to_collection"
            case budget, genres, homepage, id
            case imdbID = "imdb_id"
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case productionCompanies = "production_companies"
            case productionCountries = "production_countries"
            case releaseDate = "release_date"
            case revenue, runtime
            case spokenLanguages = "spoken_languages"
            case status, tagline, title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
    
    class MovieViewModel {
        var id: Int?
        var title: String?
        var genres: [GenreEntity]?
        var releaseDate: Date?
        var overview: String?
        var duration: String?
        var posterPath: String?
        
        init() {}
        
        init(from entity: MovieEntity) {
            id = entity.id
            title = entity.title
            genres = entity.genres
            overview = entity.overview
            posterPath = entity.posterPath
            
            if let rDate = entity.releaseDate {
                releaseDate = Date.fromString(rDate, format: AppConstants.DateFormat.YYYYMMDD_MINUS)
            }
        }
    }
}

// MARK: - Collection
struct CollectionEntity: Codable {
    let id: Int?
    let name, posterPath, backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct GenreEntity: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ProductionCompany
struct ProductionCompanyEntity: Codable {
    let id: Int?
    let logoPath: String?
    let name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountryEntity: Codable {
    let iso3166_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguageEntity: Codable {
    let englishName, iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
