//
//  InitialArtistFetchResponseModelTests.swift
//  iTuneArtistTests
//
//  Created by Sai Leung on 2/21/21.
//

import XCTest
@testable import iTuneArtist

class InitialArtistFetchResponseModelTests: XCTestCase {
    
    var mockInitialArtistFetchResponse: InitialArtistFetchResponse?

    override func setUpWithError() throws {
        let results: [Artist] = createMockFetchedArtistResults()
        mockInitialArtistFetchResponse = InitialArtistFetchResponse(results: results)
    }

    override func tearDownWithError() throws {
        mockInitialArtistFetchResponse = nil
    }

    func test_InitialArtistFetchResponse_results_count() throws {
        guard let mockInitialArtistFetchResponse = mockInitialArtistFetchResponse,
              case let resultsCount = mockInitialArtistFetchResponse.results.count
        else {
            XCTFail("Expected non-nil initialArtistFetchResponse")
            return
        }
        
        XCTAssertEqual(resultsCount, 2)
    }
    
    func test_InitialArtistFetchResponse_second_results() throws {
        guard let mockInitialArtistFetchResponse = mockInitialArtistFetchResponse,
              case let secondMockArtist = mockInitialArtistFetchResponse.results[1]
        else {
            XCTFail("Expected non-nil initialArtistFetchResponse and second result with value")
            return
        }
        
        XCTAssertEqual(secondMockArtist.artistName, "Justin Timberlake")
        XCTAssertEqual(secondMockArtist.trackName, "CAN'T STOP THE FEELING!")
        XCTAssertEqual(secondMockArtist.releaseDate, "2016-05-06T07:00:00Z")
        XCTAssertEqual(secondMockArtist.trackPrice, 1.29)
        XCTAssertEqual(secondMockArtist.primaryGenreName, "Soundtrack")
    }
    
    private func createMockFetchedArtistResults() -> [Artist] {
        var results: [Artist] = []
        let firstMockArtist = Artist(artistName: "Alicia Keys", trackName: "Karma", releaseDate: "2003-12-02T08:00:00Z", trackPrice: 1.29, primaryGenreName: "R&B/Soul")
        let secondMockArtist = Artist(artistName: "Justin Timberlake", trackName: "CAN'T STOP THE FEELING!", releaseDate: "2016-05-06T07:00:00Z", trackPrice: 1.29, primaryGenreName: "Soundtrack")
        results.append(firstMockArtist)
        results.append(secondMockArtist)
        return results
    }

}
