//
//  MovieSelectionDelegate.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 10.07.24.
//

import Foundation

protocol MovieSelectionDelegate: AnyObject {
    func didSelectMovie(_ movie: MovieResult)
}
