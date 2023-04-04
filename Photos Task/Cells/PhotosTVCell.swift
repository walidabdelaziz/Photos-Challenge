//
//  PhotosTVCell.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import UIKit
import SDWebImage

class PhotosTVCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var authorImg: UIImageView!
    
    var photo: Photos? {
        didSet {
            guard let photo = photo else { return }
            authorImg.sd_setImage(with: URL(string: photo.downloadURL ?? ""))
            nameLbl.text = photo.author ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
