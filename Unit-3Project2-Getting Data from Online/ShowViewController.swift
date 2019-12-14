//
//  ViewController.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/13/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
 
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shows = [Show]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var searchQuary = "" {
        didSet{
            DispatchQueue.main.async {
                self.searchShow(searchQuary: self.searchQuary.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.title = "TV Shows"
        tableView.delegate = self
        searchBar.delegate = self
        searchShow(searchQuary: searchQuary)

    }
    
   
    // this function is instead of loadData function, because we are loading empty TableView, it populates when you statrt search
    func searchShow(searchQuary: String) {
        ShowAPIClient.fetchShow(for: searchQuary, completion:  { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let shows):
                self?.shows = shows
            }
        })
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let episodeVC = segue.destination as? EpisodesViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("error")
        }
        
        let episodesInfo = shows[indexPath.row]
        episodeVC.show = episodesInfo
    }
}

extension ShowViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as? ShowCell else {
            fatalError("could not dequeue showCell")
        }
        let show = shows[indexPath.row]
        
        cell.configureCell(for: show)
        return cell
    }
}

extension ShowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension ShowViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
       
        
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchShow(searchQuary: searchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
     ShowAPIClient.fetchShow(for: searchQuery, completion:  { [weak self] (result) in
           switch result {
           case .failure(let appError):
               print("error: \(appError)")
           case .success(let shows):
               self?.shows = shows
           }
       })
   }
   
    }

