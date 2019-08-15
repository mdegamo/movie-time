//
//  MovieResponseModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

/// This struct is used as an object representation from the list of movies
/// returned by iTunes' json string.
struct MovieResponseModel : Decodable {
    
    let id: TrackId?
    let title: String?
    let artist: String?
    let artworkUrl: String?
    let price: Float?
    let genre: String?
    let longDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case artist = "artistName"
        case artworkUrl = "artworkUrl100"
        case price = "trackPrice"
        case genre = "primaryGenreName"
        case longDescription
    }
    
}
