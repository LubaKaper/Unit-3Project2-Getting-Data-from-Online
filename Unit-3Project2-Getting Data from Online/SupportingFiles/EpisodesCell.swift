//
//  EpisodesCell.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/14/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class EpisodesCell: UITableViewCell {

    
    @IBOutlet weak var episodeImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    
    
   // private var urlString = ""
    
    
    func configureCell(for episode: EpisodeInfo) {
        nameLabel.text = episode.name
        seasonEpisodeLabel.text = "Season: \(episode.season ?? 0) Episode: \(episode.number ?? 0)"
        
        episodeImage.getImage(with: episode.image?.original ?? "") { [weak self](resullt) in
            switch resullt {
            case .failure:
                DispatchQueue.main.async {
                    self?.episodeImage.image = UIImage(systemName: "excaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.episodeImage.image = image
                }
            }
        }
        
    }
    // gets rif of flickering
    override func prepareForReuse() {
        super .prepareForReuse()
        // empty out image view
        episodeImage.image = nil
    }

}
