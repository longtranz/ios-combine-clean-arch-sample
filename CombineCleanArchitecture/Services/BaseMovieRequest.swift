//
//  BaseMovieRequest.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

protocol BaseMovieRequestProtocol {
    var language: String { get }
    var apiKey: String { get }
    var requestType: AppConstants.API.RequestType { get }
    var params: [String: String] { get }
    func url() -> URL?
}

class BaseMovieRequest: BaseMovieRequestProtocol {
    var language: String
    var apiKey: String = AppConstants.APIKey
    var requestType: AppConstants.API.RequestType
    var params: [String: String] = [:]
    
    init(_ requestType: AppConstants.API.RequestType, language: String) {
        self.requestType = requestType
        self.language = language
    }
    
    func url() -> URL? {
        var urlRequest = URLComponents(string: requestType.url)
        
        urlRequest?.queryItems = [
            URLQueryItem(name: "language", value: language),
            URLQueryItem(name: "api_key", value: apiKey),
        ]
        
        params.forEach { entry in
            urlRequest?.queryItems?.append(URLQueryItem(name: entry.key, value: entry.value))
        }
        
        return urlRequest?.url
    }
}
