//
//  Artist.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import Foundation

struct Artist: Codable {
    let artistName: String
    let trackName: String
    let releaseDate: String
    let trackPrice: Double
    let primaryGenreName: String
    let albumImage: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case releaseDate
        case trackPrice
        case primaryGenreName
        case albumImage = "artworkUrl100"
    }
}
