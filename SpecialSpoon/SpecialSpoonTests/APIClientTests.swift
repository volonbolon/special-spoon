//
//  APIClientTests.swift
//  SpecialSpoonTests
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import XCTest
import Combine

@testable import SpecialSpoon

struct APIManagerMock: APIClient {
    func searchForTerm(_ term: String,
                       offset: Int,
                       pageSize: Int) -> AnyPublisher<[SearchResult], APIClientError> {
        let searchResult = SearchResult(trackId: 308345539,
                                        trackName: "In utero",
                                        previewUrl: "https://audio-ssl.itunes.apple.com/itunes-assets/Music/b9/6d/cc/mzm.ydaoahqv.aac.p.m4a",
                                        collectionViewUrl: "https://music.apple.com/us/album/in-utero/308345440?i=308345539&uo=4",
                                        artistName: "Kells",
                                        collectionName: "Lueurs", artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music/v4/17/58/d8/1758d85c-ce46-e742-8a70-bf4711b37629/source/100x100bb.jpg")
        
        return Just([searchResult])
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
}

class SearchViewModelTests: XCTestCase {
    var subscriptions = [AnyCancellable]()

    func testAPI() {
        let apiClient = APIManagerMock()
        let model = SearchViewModel(apiClient: apiClient)
        
        let expectation = XCTestExpectation(description: "Expect loading data")
        
        model
            .$searchResults
            .receive(on: DispatchQueue.main)
            .sink { (results) in
                if let result = results.first {
                    XCTAssertEqual(result.id, 308345539, "result ID \(result.id) should be 308345539")
                    expectation.fulfill()
                }
            }
            .store(in: &subscriptions)
        
        model.searchForTerm("In Utero")
        
        wait(for: [expectation], timeout: 30)
    }
}
