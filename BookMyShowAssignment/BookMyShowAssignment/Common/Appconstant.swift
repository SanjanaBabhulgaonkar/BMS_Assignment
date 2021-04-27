//
//  Appconstant.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 26/04/21.
//

import UIKit

class Appconstant: NSObject {

    static let shared = Appconstant()
    
    var apiKeyConstant = "39cc9a1b8a788b673e9b63ad569ad5fc"
    let baseAPIURL = "https://api.themoviedb.org/3/movie/"

    
    /// Formats date to given format based on current format
    ///
    /// - Parameters:
    ///   - date: date
    ///   - currentformat: currentformat
    ///   - requiredformat: requiredformat
    /// - Returns: formatted date string
    public func formatDate(date: String , currentformat : String , requiredformat : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = currentformat
        formatter.timeZone=NSTimeZone(name: "UTC")! as TimeZone
        let formatteddate = formatter.date(from: date)
        formatter.dateFormat = requiredformat
        
        var dateinstring =  ""
        
        if(formatteddate != nil)
        {
            dateinstring = formatter.string(from: formatteddate!)
        }
        return dateinstring
    }
    
}
