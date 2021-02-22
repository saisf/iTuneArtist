//
//  RequestError.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import Foundation

enum RequestError: Error {
    case artistUrlSessionError(error: Error)
}
