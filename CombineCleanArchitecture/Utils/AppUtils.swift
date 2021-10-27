//
//  AppUtils.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

class AppUtils {
    static func convertToTimeString(totalTime: Int) -> String {
        let hour = totalTime / 60
        let minute = totalTime - hour * 60
        var duration = ""
        
        if hour > 0 {
            duration.append("\(hour)h ")
        }
        
        duration.append("\(minute)m")
        
        return duration
    }
}
