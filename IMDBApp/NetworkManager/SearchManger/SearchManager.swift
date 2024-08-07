//
//  SearchManager.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import Foundation

protocol SearchManagerProtocol {
    func getSearchItems(text: String, page: Int, complete: @escaping((Search?, Error?)->()))
}

class SearchManager: SearchManagerProtocol {
    static let shared = SearchManager()
    
    func getSearchItems(text: String, page: Int, complete: @escaping ((Search?, Error?) -> ())) {
        URLSession.shared.fetch(type: Search.self,
                                url: SearchEndpoint.search.path + "&query=\(text)&page=\(page)",
                                method: .GET, headers: nil) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
    
}

