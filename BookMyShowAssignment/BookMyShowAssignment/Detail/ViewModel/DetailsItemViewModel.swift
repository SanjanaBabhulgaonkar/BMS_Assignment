//
//  DetailsItemViewModel.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 27/04/21.
//

import UIKit

class DetailsItemViewModel: NSObject {

    //Mark :- Variables
    var dictDetails : DetailsBaseItem?
    var maxPageCount : Int = 1
    
    func movieDetails(movieId:String,completion: @escaping () -> Void, completionError: @escaping () -> Void)
    {
        let urlString = Appconstant.shared.baseAPIURL + movieId + "?api_key=" + Appconstant.shared.apiKeyConstant  + "&language=en-US"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let dictData = parse(json: data)
                dictDetails = dictData
                completion()
            }
        }
    }
    
    
    /// This method is used to show data
    /// - Parameters:
    ///   - cell: DetailsTableCell
    ///   - row: row
    func configureData(cell : DetailsTableCell, row: Int){
        if self.dictDetails != nil{
            let objData = dictDetails
            cell.lblTitle.text = objData?.original_title
            
            let releaseDate = Appconstant.shared.formatDate(date: (objData?.release_date)! , currentformat : "yyyy-MM-dd" , requiredformat : "MMM dd,yyyy")
            cell.lblGeners.text = (objData?.genres?[0].name!)! + "  |  " + releaseDate
 
            let finalImgUrl = Appconstant.shared.imageBasePath + (objData?.backdrop_path ?? "")
            let urlString = finalImgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imagURL = URL(string: urlString ?? "")
            cell.imgViw.kf.setImage(with: imagURL)
            cell.lblDescription.text = objData?.overview
        }
    }
    
    func parse(json: Data) -> DetailsBaseItem? {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(DetailsBaseItem.self, from: json) {
            return jsonPetitions
        }
        return nil
    }

}
