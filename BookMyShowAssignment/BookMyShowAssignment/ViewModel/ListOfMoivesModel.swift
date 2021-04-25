//
//  ListOfMoivesModel.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import UIKit

class ListOfMoivesModel: NSObject {
    
    fileprivate var contentsArray = [[String:Any]]()
    var arrMatch_Stats  = [[String: Any]]()

    var pageCount = 1
    var apiKeyConstant = "39cc9a1b8a788b673e9b63ad569ad5fc"
    var arrResults = [Results]()
    var imageBasePath = "https://image.tmdb.org/t/p/w500"

    
    func wsListing(completion: @escaping () -> Void, completionError: @escaping () -> Void)
    {
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + apiKeyConstant + "&language=en-US&page=" + String(pageCount)
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                arrResults = parse(json: data) ?? []
                
            }
        }
    }
 
    func numberOfRowsForSection() -> Int
    {
        if self.arrResults.count > 0{
            return self.arrResults.count
        }
        return 0
    }

    func configureData(cell : ListOfMoviesTableCell, row: Int){
        if self.arrResults.count > 0{
            let objResults = self.arrResults[row]
            cell.lblMovieTitle.text = objResults.original_title
            cell.lblReleaseDate.text = objResults.release_date
            let finalImgUrl = imageBasePath + (objResults.poster_path ?? "") ?? "" 
        }
    }

    
    func parse(json: Data) -> [Results]? {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(ListOfMoviesItem.self, from: json) {
            return jsonPetitions.results ?? []
        }
        return nil
    }

}
