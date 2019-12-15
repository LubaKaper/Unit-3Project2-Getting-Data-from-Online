//
//  EpisodesViewController.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/14/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class EpisodesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var show: Show?
    
    var episodes = [EpisodeInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getEpisodes(for: show?.id?.description ?? "")
        
    }
    
   
    
    func getEpisodes(for theShow: String) {
        EpisodesAPIClient.fetchEpisodes(for: theShow) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let episodes):
                self?.episodes = episodes
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeDetailVC = segue.destination as? EpisodeDetailController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        let episodeInfo = episodes[indexPath.row]
        episodeDetailVC.episodeInfo = episodeInfo
    }
   
}

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as? EpisodesCell else {
            fatalError("could not dequeue episodeCell")
        }
        let episode = episodes[indexPath.row]
        cell.configureCell(for: episode)
        cell.backgroundColor = .systemGray
        return cell
    }
}
extension EpisodesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
