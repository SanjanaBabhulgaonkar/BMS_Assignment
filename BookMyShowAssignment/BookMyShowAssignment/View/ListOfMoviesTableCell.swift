//
//  ListOfMoviesTableCell.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import UIKit

class ListOfMoviesTableCell: UITableViewCell {
    
    //MARK : Iboutlets
    @IBOutlet weak var viwBackground: UIView!
    @IBOutlet weak var imgViw: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
