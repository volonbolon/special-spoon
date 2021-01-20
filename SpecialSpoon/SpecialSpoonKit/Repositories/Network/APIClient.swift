//
//  APIClient.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation
import Combine

enum APIClientError: Error {
    case invalidSearch
    case addressUnreachable(URL)
    case invalidResponse
}

extension APIClientError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return NSLocalizedString("Unable to parse response",
                                     comment: "Unable to parse response")
        case .addressUnreachable(let url):
            let format = NSLocalizedString("Unable to reach %s",
                                           comment: "Unable to reach")
            return String(format: format, url.absoluteString)
        case .invalidSearch:
            return NSLocalizedString("Invalid Search", comment: "Invalid Search")
        }
    }
}

extension APIClientError: Identifiable {
    var id: String {
        return localizedDescription
    }
}


protocol APIClient {
    func searchForTerm(_ term: String,
                       offset: Int,
                       pageSize: Int) -> AnyPublisher<[SearchResult], APIClientError>
}
