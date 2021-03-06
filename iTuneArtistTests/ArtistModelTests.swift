//
//  iTuneArtistTests.swift
//  iTuneArtistTests
//
//  Created by Sai Leung on 2/20/21.
//

import XCTest
@testable import iTuneArtist

class ArtistModelTests: XCTestCase {
    
    var mockArtist: Artist?

    override func setUpWithError() throws {
        mockArtist = Artist(artistName: "Alicia Keys", trackName: "Karma", releaseDate: "2003-12-02T08:00:00Z", trackPrice: 1.29, primaryGenreName: "R&B/Soul", albumImage: "https://is1-ssl.mzstatic.com/image/thumb/Video114/v4/b2/7f/10/b27f10ca-0d0f-a5a0-08f3-6657938aa3ac/source/100x100bb.jpg")
    }

    override func tearDownWithError() throws {
        mockArtist = nil
    }

    func test_Artist_artistName() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.artistName, "Alicia Keys")
    }
    
    func test_Artist_trackName() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.trackName, "Karma")
    }
    
    func test_Artist_releaseDate() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.releaseDate, "2003-12-02T08:00:00Z")
    }
    
    func test_Artist_trackPrice() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.trackPrice, 1.29)
    }
    
    func test_Artist_primaryGenreName() {
        guard let mockArtist = mockArtist else {
            XCTFail("Expected non-nil artist")
            return
        }
        XCTAssertEqual(mockArtist.primaryGenreName, "R&B/Soul")
    }

}
