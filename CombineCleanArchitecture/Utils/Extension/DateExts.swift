//
//  DateExts.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

extension Date {    
    func toString(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    static func fromString(_ dateStr: String, format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.date(from: dateStr)
    }
}
