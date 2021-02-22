//
//  ArtistViewModelTests.swift
//  iTuneArtistTests
//
//  Created by Sai Leung on 2/22/21.
//

import XCTest
@testable import iTuneArtist

class ArtistViewModelTests: XCTestCase {
    
    var mockArtist: Artist?
    var mockArtistViewModel: ArtistViewModel?

    override func setUpWithError() throws {
        mockArtist = Artist(artistName: "Alicia Keys", trackName: "Karma", releaseDate: "2003-12-02T08:00:00Z", trackPrice: 1.29, primaryGenreName: "R&B/Soul", albumImage: "https://is1-ssl.mzstatic.com/image/thumb/Video114/v4/b2/7f/10/b27f10ca-0d0f-a5a0-08f3-6657938aa3ac/source/100x100bb.jpg")
        mockArtistViewModel = ArtistViewModel(artist: mockArtist!)
    }

    override func tearDownWithError() throws {
        mockArtist = nil
    }

    func test_ArtistViewModel_artistName_equal_to_Artist_artistName() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.artistName, mockArtistViewModel?.name)
    }
    
    func test_ArtistViewModel_trackName_equal_to_Artist_trackName() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.trackName, mockArtistViewModel?.trackName)
    }
    
    func test_ArtistViewModel_trackPrice_equal_to_Artist_trackPrice() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        let mockArtistTrackPrice = "$ \(mockArtist.trackPrice)"
        if let mockArtistViewModelTrackPrice = mockArtistViewModel?.price {
            XCTAssertEqual(mockArtistTrackPrice, mockArtistViewModelTrackPrice)
        }
    }
    
}
