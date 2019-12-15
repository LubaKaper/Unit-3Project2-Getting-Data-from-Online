//
//  EpisodeDetailController.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/14/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class EpisodeDetailController: UIViewController {
    
    
    @IBOutlet weak var episodeImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var seasonEpisodeLabel: UILabel!
    
    
    @IBOutlet weak var textView: UITextView!
    
    var episodeInfo: EpisodeInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        guard let episode = episodeInfo else {
            fatalError("verify prepare for segue")
        }
        
        view.backgroundColor = .systemGray2
        nameLabel.text = episode.name
        seasonEpisodeLabel.text = "Season: \(episode.season ?? 0) Episode: \(episode.number ?? 0)"
        textView.text = episode.summary
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
   

}
