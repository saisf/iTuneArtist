//
//  ArtistListView.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import SwiftUI

struct ArtistListView: View {
    
    @ObservedObject var viewController: ViewController
    
    var body: some View {
        List(viewController.artistViewModels) { artistViewModel in
            HStack {
                Text("\(artistViewModel.name)")
                Text("\(artistViewModel.trackName)")
                Text("\(artistViewModel.releaseDate)")
                Text("\(artistViewModel.price)")
                Text("\(artistViewModel.genre)")
            }
            
        }
    }
}

class ArtistViewModel: Identifiable {
    
    let id = UUID()
    
    var artist: Artist
    
    init(artist: Artist) {
        self.artist = artist
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
    
}
