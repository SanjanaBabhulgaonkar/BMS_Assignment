//
//  ViewController.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import UIKit

class ViewController: UIViewController {

    //MARK : IBoutlets
    @IBOutlet weak var tblViw: UITableView!
    
    //Mark :- Variables
    var listOfMoivesModel = ListOfMoivesModel()
    var pageCount = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
        initialse()
    }
    
    func initialse() {
        let searchView = getSearchButton()
        let search = UIBarButtonItem.init(customView: searchView)
        self.navigationItem.setRightBarButtonItems([search], animated: true)
    }
    
    /// This method is used to get the custom search button view
     ///
     /// - Returns: view
     func getSearchButton() -> UIView {
         
         let searchButton = UIButton.init(type: .custom)
         
         searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
         
         let buttonimage = UIImageView(frame: CGRect(x: 5    , y: 10, width: 20, height: 20))
        searchButton.frame = buttonimage.frame
         buttonimage.contentMode = .scaleAspectFit
         buttonimage.image = UIImage(named:"Search")

         let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 40))
         buttonView.addSubview(buttonimage)
         buttonView.addSubview(searchButton)
         
         return buttonView
         
     }
    
    
    /// This method is used to show dynmamic data
    func loadData(){
        listOfMoivesModel.wsListing(pageCount: pageCount, completion: {
            self.tblViw.reloadData()
        }, completionError:  {
           
        })
    }
    
    /// This method is used to show search view controller
    @objc func searchTapped(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        vc?.arrResults = listOfMoivesModel.getDataForArray() ?? []
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    /// This method is used to show detail page
    @objc func bookTapped(sender:UIButton){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.selecetedMovieId = listOfMoivesModel.getSelectedItemMovieID(row: sender.tag)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    
    // number of rows in table view
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return listOfMoivesModel.numberOfRowsForSection()
       }
       
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListOfMoviesTableCell", for: indexPath) as! ListOfMoviesTableCell
        cell.viwBackground.layer.cornerRadius = 5
        cell.imgViw.layer.cornerRadius = 5
        cell.imgViw.layer.borderColor = UIColor.black.cgColor
        cell.imgViw.layer.borderWidth = 1
        cell.viwBackground.layer.borderWidth = 1
        cell.viwBackground.layer.borderColor = UIColor.black.cgColor
        cell.btnBook.setTitle("BOOK", for: .normal)
        cell.btnBook.layer.cornerRadius = 5
        cell.btnBook.tag = indexPath.row
        cell.btnBook.addTarget(self,action:#selector(bookTapped(sender:)),for: .touchUpInside)
        listOfMoivesModel.configureData(cell: cell, row: indexPath.row)
        return cell
     }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.selecetedMovieId = listOfMoivesModel.getSelectedItemMovieID(row: indexPath.row)
        self.navigationController?.pushViewController(vc!, animated: true)
    }
        
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         let spinner = UIActivityIndicatorView(style: .gray)
         spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
         let lastSectionIndex = tableView.numberOfSections - 1
         let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
             let pageCountFromAPI = listOfMoivesModel.getMaxPageCount()
                if pageCount < pageCountFromAPI{
                    spinner.startAnimating()
                    self.tblViw.tableFooterView = spinner
                    self.tblViw.tableFooterView?.isHidden = false
                    pageCount = pageCount+1
                    
                    if pageCount <= listOfMoivesModel.getMaxPageCount()   //scroll delegate
                    {
                        listOfMoivesModel.wsListing(pageCount: pageCount, completion: {
                            self.tblViw.reloadData()
                        }, completionError:  {
                           
                        })
                    }
                }
        }
         else{
             spinner.stopAnimating()
             spinner.isHidden = true
             self.tblViw.tableFooterView?.isHidden = true
         }
     }

}
