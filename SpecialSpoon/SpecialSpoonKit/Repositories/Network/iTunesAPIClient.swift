//
//  iTunesAPIClient.swift
//  SpecialSpoon
//
//  Created by Ariel Rodriguez on 20/01/2021.
//

import Foundation
import Combine
import VolonbolonKit

struct iTunesAPIClient: APIClient {
    let apiQueue = DispatchQueue(label: "Parsing",
                                 qos: .default,
                                 attributes: .concurrent)
    private let apiManager: APIManager
    private let decoder = JSONDecoder()
    private var offset = 0
    
    init(manager: APIManager = VolonbolonKit.Networking.Manager.init()) {
        self.apiManager = manager
    }
    
    func searchForTerm(_ term: String,
                       offset: Int = 0,
                       pageSize: Int = 20) -> AnyPublisher<[SearchResult], APIClientError> {
        guard let encodedTerm = term.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            return Fail<[SearchResult], APIClientError>(error: APIClientError.invalidSearch)
                .eraseToAnyPublisher()
        }
        let urlString = "https://itunes.apple.com/search?term=\(encodedTerm)&mediaType=music&limit=\(pageSize)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            return Fail<[SearchResult], APIClientError>(error: APIClientError.invalidSearch)
                .eraseToAnyPublisher()
        }
        return apiManager
            .loadData(from: url)
            .decode(type: Results.self, decoder: decoder)
            .mapError { (error) -> APIClientError in
                switch error {
                case is URLError:
                    return APIClientError.addressUnreachable(url)
                default:
                    return APIClientError.invalidResponse
                }
            }
            .map { $0.results }
            .filter { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
}
