//
//  MovieResponseModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import Foundation

struct MovieResponseModel : Decodable {
    
    let id: TrackId?
    let title: String?
    let artworkUrl: String?
    let price: Float?
    let genre: String?
    let longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case artworkUrl = "artworkUrl100"
        case price = "trackPrice"
        case genre = "primaryGenreName"
        case longDescription
    }
    
}
