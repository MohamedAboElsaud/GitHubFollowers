//
//  Data+Ext.swift
//  GitHubFollowers
//
//  Created by mohamed ahmed on 02/10/2023.
//

import Foundation

extension Date{
    func convertToMonthYearFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
}
