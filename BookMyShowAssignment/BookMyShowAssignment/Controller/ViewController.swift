//
//  ViewController.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import UIKit

class ViewController: UIViewController {

    var listOfMoivesModel = ListOfMoivesModel()
    @IBOutlet weak var tblViw: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    
    /// This method is used to show dynmamic data
    func loadData(){
        listOfMoivesModel.wsListing(completion: {
            self.tblViw.reloadData()
        }, completionError:  {
           
        })
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
         cell.btnBook.setTitle("BOOK", for: .normal)
         listOfMoivesModel.configureData(cell: cell, row: indexPath.row)
           // set the text from the data model
           return cell
       }
       
       // method to run when table view cell is tapped
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("You tapped cell number \(indexPath.row).")
       }
}
