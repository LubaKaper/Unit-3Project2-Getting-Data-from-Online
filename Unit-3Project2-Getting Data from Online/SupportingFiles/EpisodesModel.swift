//
//  EpisodesModel.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/13/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation
struct EpisodeInfo: Decodable {
    let name: String
    let season: Int
    let episode: Int
    let image: [EpisodeImage]
}

struct EpisodeImage: Decodable {
    let medium: String
    let original: String
}
