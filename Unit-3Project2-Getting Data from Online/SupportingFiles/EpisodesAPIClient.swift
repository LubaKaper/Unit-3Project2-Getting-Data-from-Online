//
//  EpisodesAPIClient.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/14/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct EpisodesAPIClient {
    static func fetchEpisodes(for showId: String, completion: @escaping (Result <[EpisodeInfo], AppError>) -> ()) {
        
//      var show: Show!
//        let showId = show.id?.description
        let episodesEndpointURL = "https://api.tvmaze.com/shows/\(showId)/episodes"
        
        guard let url = URL(string: episodesEndpointURL) else {
            completion(.failure(.badURL(episodesEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let episodes = try JSONDecoder().decode([EpisodeInfo].self, from: data)
                    completion(.success(episodes))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
