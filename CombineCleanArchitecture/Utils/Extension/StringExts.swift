//
//  StringExts.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/4/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func size(withFont font: UIFont) -> CGSize {
        let textAttribute = [NSAttributedString.Key.font: font]
        
        return (self as NSString).size(withAttributes: textAttribute)
    }
}
