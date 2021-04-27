//
//  DetailViewController.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 26/04/21.
//

import UIKit

class DetailViewController: UIViewController {

    //Mark :- IBOutlets
    @IBOutlet weak var tblViw: UITableView!
    
    //Mark :- Variables
    var selecetedMovieId : String = ""
    var detailsItemViewModel = DetailsItemViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }    
    
    /// This method is used to get movie data
    func loadData(){
        detailsItemViewModel.movieDetails(movieId: selecetedMovieId, completion: {
            self.tblViw.reloadData()
        }, completionError:  {
           
        })
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource  {
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
       
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableCell", for: indexPath) as! DetailsTableCell
        detailsItemViewModel.configureData(cell: cell, row: indexPath.row)
        return cell
     }
     

}

