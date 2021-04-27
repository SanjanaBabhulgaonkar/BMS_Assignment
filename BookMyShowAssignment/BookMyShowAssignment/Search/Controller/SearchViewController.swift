//
//  SearchViewController.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 26/04/21.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK : IBoutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblViw: UITableView!
    @IBOutlet weak var lblRecentlySearch: UILabel!
    
    //Mark :- Variables
    var arrResults = [Results]()
    var arrSearchResult = [Results]()
    var isSearchClicked : Bool = false
    var searchedText : String = ""
    var inputArray = [String]()
    var listOfMoivesModel = ListOfMoivesModel()

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
            if Appconstant.shared.arrCachedData.count > 0{
                if Appconstant.shared.arrCachedData.count > 5{
                    return 5
                }else{
                    return Appconstant.shared.arrCachedData.count
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
            if Appconstant.shared.arrCachedData.count > 0{
                lblRecentlySearch.text = "Recently Searched"
                cell.textLabel?.text = Appconstant.shared.arrCachedData[indexPath.row]
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
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        if isSearchClicked{
            if arrSearchResult.count > 0{
                let clickedItem = arrSearchResult[indexPath.row].title
                Appconstant.shared.arrCachedData.append(clickedItem!)
                vc?.selecetedMovieId = String(arrSearchResult[indexPath.row].id!)
            }
        }else{
            if arrResults.count > 0{
                let clickedItem = arrResults[indexPath.row].title
                Appconstant.shared.arrCachedData.append(clickedItem ?? "")
                vc?.selecetedMovieId = String(arrResults[indexPath.row].id!)
            }
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)

    }
}

extension SearchViewController:  UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedText = searchBar.text!
        if searchedText == ""{
            isSearchClicked = false
            self.tblViw.reloadData()
        }else{
            isSearchClicked = true
            getSearchResult(inputText: searchBar.text!)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchedText = searchBar.text!
        searchBar.resignFirstResponder()
    }
    
    func getSearchResult(inputText : String) {
        let trimmedString = searchedText.trimmingCharacters(in: .whitespacesAndNewlines)
        let result = trimmedString.split(separator: " ")
        
        let splitStringArray = trimmedString.split(separator: " ").map { String($0) }
        inputArray = splitStringArray

        if inputArray.count > 0{
            for j in 0...inputArray.count - 1{
                let inputElement = inputArray[j]
                  for i in 0...arrResults.count - 1{
                    let objMovie = arrResults[i]
                    if let searchedTitle = arrResults[i].title{
                        let result = searchedTitle.split(separator: " ")
                        for s in 0...result.count - 1{
                            let tempString = result[s].prefix(inputElement.count)
                            if tempString == inputElement{
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
