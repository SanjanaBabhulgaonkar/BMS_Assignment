//
//  SearchViewController.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 26/04/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblViw: UITableView!
    
    var arrResults = [Results]()
    var arrCachedData = [String]()
    var arrSearchResult = [Results]()
    
    var isSearchClicked : Bool = false
    var searchedText : String = ""
    var inputArray = [String]()

   /* var staticArray = ["Aquaman",
                       "Spider-Man: Into the Spider-Verse",
                       "KGF",
                       "Ralph Breaks The Internet",
                       "The Grinch",
                       "Bohemian Rhapsody",
                       "Maari",
                       "Dilwale Dulhania Le Jaayenge"]*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblViw.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        searchBar.placeholder = "Search movie"
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource  {
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchClicked{
            if arrSearchResult.count > 0{
                return arrSearchResult.count
            }
        }else{
            if arrCachedData.count > 0{
                if arrCachedData.count > 5{
                    return 5
                }else{
                    return arrCachedData.count
                }
            }else{
                if arrResults.count > 0{
                    return arrResults.count
                }
            }
        }
        return 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell")!
        if isSearchClicked{
            if arrSearchResult.count > 0{
                cell.textLabel?.text = arrSearchResult[indexPath.row].title
            }
        }else{
            if arrCachedData.count > 0{
                cell.textLabel?.text = arrCachedData[indexPath.row]
            }else{
                if arrResults.count > 0{
                    cell.textLabel?.text = arrResults[indexPath.row].title
                }
            }
        }
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearchClicked{
            if arrSearchResult.count > 0{
                let clickedItem = arrSearchResult[indexPath.row].title
                arrCachedData.append(clickedItem!)
            }
        }else{
            if arrResults.count > 0{
                let clickedItem = arrSearchResult[indexPath.row].title
                arrCachedData.append(clickedItem ?? "")
            }
        }
        print("arrCachedData elements \(arrCachedData)")
    }
}

extension SearchViewController:  UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        searchedText = searchBar.text!
        getSearchResult(inputText: searchBar.text!)
        isSearchClicked = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchedText = searchBar.text!
        searchBar.resignFirstResponder()
    }
    
    func getSearchResult(inputText : String) {
        let trimmedString = searchedText.trimmingCharacters(in: .whitespacesAndNewlines)
        print("trimmedString \(trimmedString)")
        let result = trimmedString.split(separator: " ")
        
        let splitStringArray = trimmedString.split(separator: " ").map { String($0) }
        inputArray = splitStringArray

        if inputArray.count > 0{
            for j in 0...inputArray.count - 1{
                let inputElement = inputArray[j]
                for i in 0...arrResults.count - 1{
                    if let objMovie = arrResults[i]{
                        let result = objMovie.split(separator: " ")
                        for s in 0...result.count - 1{
                            let tempString = result[s].prefix(inputElement.count)
                            if tempString == inputElement{
                                print("output array for multiple \(objMovie)")
                                self.arrSearchResult.append(objMovie)
                            }
                            self.tblViw.reloadData()
                        }
                    }
                }
            }
        }
    }
}
