//
//  AlertError.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import Foundation

enum AlertError: Error {
    case emptyString
    case artistFetchSessionError
    case noArtistFound
}
