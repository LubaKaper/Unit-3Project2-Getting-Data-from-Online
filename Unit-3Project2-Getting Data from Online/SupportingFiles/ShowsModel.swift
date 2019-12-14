//
//  ShowsModel.swift
//  Unit-3Project2-Getting Data from Online
//
//  Created by Liubov Kaper  on 12/13/19.
//  Copyright © 2019 Luba Kaper. All rights reserved.
//

import Foundation

struct ShowInfo: Decodable {
    let show: Show
}

struct Show: Decodable {
    let name: String?
    let image:Image?
    let rating: Rating
    let id: Int?
}

struct Image: Decodable {
    let medium: String?
    let original: String?
}

struct Rating: Decodable {
    let average: Double?
}


