//
//  Webservice.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import Foundation
import Combine

class Webservice {
    
    func fetchArtist(name: String) -> AnyPublisher<[Artist], Error> {
        
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
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

enum RequestError: Error {
    case artistUrlSessionError(error: Error)
}
