//
//  DetailsTableCell.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 27/04/21.
//

import UIKit

class DetailsTableCell: UITableViewCell {

    //Mark :- IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viwBackground: UIView!
    @IBOutlet weak var lblGeners: UILabel!
    @IBOutlet weak var imgViw: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
