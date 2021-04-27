//
//  ListOfMoivesModel.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import UIKit
import Kingfisher

class ListOfMoivesModel: NSObject {
 
    var arrResults = [Results]()
    var imageBasePath = "https://image.tmdb.org/t/p/w500"
    var maxPageCount : Int = 1
    
    func wsListing(pageCount:Int,completion: @escaping () -> Void, completionError: @escaping () -> Void)
    {
        let urlString = Appconstant.shared.baseAPIURL + "now_playing?api_key=" + Appconstant.shared.apiKeyConstant  + "&language=en-US&page=" + String(pageCount)
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let arrData = parse(json: data) ?? []
                for i in 0..<arrData.count{
                    let dictIndex = arrData[i]
                    self.arrResults.append(dictIndex)
                }
                completion()
            }
        }
    }
  
     func getDataForArray() -> [Results]?{
        if self.arrResults.count > 0{
            return self.arrResults
        }
        return nil
    }
    
    func numberOfRowsForSection() -> Int
    {
        if self.arrResults.count > 0{
            return self.arrResults.count
        }
        return 0
    }
    
    func getMaxPageCount() -> Int
    {
        return self.maxPageCount
    }

    func configureData(cell : ListOfMoviesTableCell, row: Int){
        if self.arrResults.count > 0{
            let objResults = self.arrResults[row]
            cell.lblMovieTitle.text = objResults.original_title
            let releaseDate = Appconstant.shared.formatDate(date: objResults.release_date! , currentformat : "yyyy-MM-dd" , requiredformat : "MMM dd,yyyy")
            cell.lblReleaseDate.text = releaseDate
            let finalImgUrl = imageBasePath + (objResults.poster_path ?? "")
            let urlString = finalImgUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imagURL = URL(string: urlString ?? "")
            cell.imgViw.kf.setImage(with: imagURL)
        }
    }

    func parse(json: Data) -> [Results]? {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(ListOfMoviesItem.self, from: json) {
            maxPageCount = jsonPetitions.total_pages ?? 1
            return jsonPetitions.results ?? []
        }
        return nil
    }

}
