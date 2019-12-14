//
//  ShowAPIClient.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/13/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct ShowAPIClient {
    static func fetchShow(for searchQuery: String, completion: @escaping (Result<[Show], AppError>) ->()) {
        
        let searchQuary = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "Friends"
        let showEndpointURL = "https://api.tvmaze.com/search/shows?q=\(searchQuary)"
        
        guard let url = URL(string: showEndpointURL) else {
            completion(.failure(.badURL(showEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([ShowInfo].self, from: data)
                    // usingsearchResults to create array of shows
                    // capturing array of shows on completion handler
                    completion(.success(searchResults.map({$0.show})))
                 
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
