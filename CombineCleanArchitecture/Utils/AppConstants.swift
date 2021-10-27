//
//  AppConstants.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static var APIKey: String = ""

    struct API {
        
        enum RequestType {
            case nowPlaying
            case popular
            case trending
            case detail(id: Int)
            
            var url: String {
                switch self {
                case .nowPlaying:
                    return Host + "/now_playing"
                case .popular:
                    return Host + "/popular"
                case .detail(let id):
                    return String(format: "%@/%d", Host, id)
                default:
                    return Host
                }
            }
        }
                
        static let Host = "https://api.themoviedb.org/3/movie"
        static let ImageHost = "https://image.tmdb.org/t/p"
    }
    
    struct DateFormat {
        static let DDMMYYYY_SLASH = "dd/MM/yyyy"
        static let YYYYMMDD_MINUS = "yyyy-MM-dd"
        static let MMMMDDYYYY = "MMMM dd, yyyy"
    }
    
    struct Color {
        static let mainBackground = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let navBackground = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        static let movieListHeaderText = #colorLiteral(red: 0.9882352941, green: 0.8156862745, blue: 0.3215686275, alpha: 1)
        static let movieListHeaderBackground = #colorLiteral(red: 0.2980392157, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
        
        // Progress bar
        static let progressBarGood = #colorLiteral(red: 0.1176470588, green: 0.8078431373, blue: 0.4705882353, alpha: 1)
        static let progressBarGoodBackground = #colorLiteral(red: 0.1176470588, green: 0.2666666667, blue: 0.1529411765, alpha: 1)
        static let progressBarAverage = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.1921568627, alpha: 1)
        static let progressBarAverageBackground = #colorLiteral(red: 0.2549019608, green: 0.2431372549, blue: 0.05490196078, alpha: 1)
    }
    
    struct Image {
        static let movieDetailCloseIcon = "CloseIcon"
    }
}
