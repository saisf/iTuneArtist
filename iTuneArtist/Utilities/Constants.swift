//
//  Constants.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import Foundation

struct Constants {
    
    struct URLs {
        
        static func artist(name: String) -> String {
            "https://itunes.apple.com/search?term=\(name)"
        }
    }
}
