//
//  MockAPIClient.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 21/01/2021.
//

import Foundation
import Combine

struct MockAPIClient: APIClient {
    let results: [SearchResult]
    
    init(results: [SearchResult]) {
        self.results = results
    }
    
    func searchForTerm(_ term: String, offset: Int, pageSize: Int) -> AnyPublisher<[SearchResult], APIClientError> {
        return Just(results)
            .setFailureType(to: APIClientError.self)
            .eraseToAnyPublisher()
    }
}
