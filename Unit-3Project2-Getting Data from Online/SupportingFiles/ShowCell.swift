//
//  ShowCell.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/14/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {

    
    @IBOutlet weak var showImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
   
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configureCell(for show: Show) {
        
        nameLabel.text = show.name
        ratingLabel.text = "RATING: \(show.rating.average?.description ?? "")"
        
        showImage.getImage(with: show.image?.original ?? "") { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showImage.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImage.image = image
                }
            }
        }
    }
    override func prepareForReuse() {
        super .prepareForReuse()
        // empty out image view
        showImage.image = nil
    }

}
