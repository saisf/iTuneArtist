//
//  ArtistViewModel.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/22/21.
//

import Foundation
import UIKit
import Combine

class ArtistViewModel: Identifiable, ObservableObject {
    
    @Published var image = UIImage(named: "defaultAlbumArtwork")!
    
    private var anyCancellable: AnyCancellable?
    private var webservice = Webservice()
    
    let id = UUID()
    
    var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
        fetchAlbumImage()
    }
    
    var name: String {
        artist.artistName
    }
    
    var trackName: String {
        artist.trackName
    }
    
    var releaseDate: String {
        let isoDate = artist.releaseDate
        let dateFormatter = ISO8601DateFormatter()
        let releaseDateFormatter = DateFormatter()
        releaseDateFormatter.dateFormat = "MMM dd,yyyy"
        if let releaseDate = dateFormatter.date(from: isoDate) {
            return releaseDateFormatter.string(from: releaseDate)
        } else {
            return "Release date unavailable"
        }
    }
    
    var price: String {
        "$ \(artist.trackPrice)"
    }
    
    var genre: String {
        artist.primaryGenreName
    }
    
    private func fetchAlbumImage() {
        anyCancellable = webservice.fetchImage(url: artist.albumImage)
            .sink(receiveCompletion: { (_) in
                /// Intentionally leave it uncalled because default image has been set if failed
            }, receiveValue: { [weak self] (data) in
                if let albumArt = UIImage(data: data) {
                    self?.image = albumArt
                }
            })
    }
}
