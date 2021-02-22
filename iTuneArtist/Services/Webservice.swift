//
//  Webservice.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import Foundation
import Combine

class Webservice {
    
    // This returns a publisher to post fetching artist data
    func fetchArtist(name: String) -> AnyPublisher<[ArtistViewModel], Error> {
        
        guard let url = URL(string: Constants.URLs.artist(name: name)) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
            
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error -> RequestError in
                return RequestError.artistUrlSessionError(error: error)
            }
            .map(\.data)
            .decode(type: InitialArtistFetchResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .map { artists -> [ArtistViewModel] in
                var artistsViewModel = [ArtistViewModel]()
                artists.forEach { (artist) in
                    artistsViewModel.append(ArtistViewModel(artist: artist))
                }
                return artistsViewModel
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    // This returns a publisher to post fetching artist album image data
    func fetchImage(url: String) -> AnyPublisher<Data, Error> {
        
        guard let url = URL(string: url) else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error -> RequestError in
                return RequestError.artistUrlSessionError(error: error)
            }
            .map(\.data)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
