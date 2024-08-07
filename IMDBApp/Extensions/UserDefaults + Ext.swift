//
//  UserDefaults + Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 17.07.24.
//

import Foundation

extension UserDefaults {
    /// Save a Codable object to UserDefaults.
    func save<T: Codable>(_ object: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            set(data, forKey: key)
        } catch {
            print("Failed to save object to UserDefaults for key \(key): \(error)")
        }
    }
    
    /// Load a Codable object from UserDefaults.
    func load<T: Codable>(forKey key: String) -> T? {
        guard let data = data(forKey: key) else { return nil }
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch {
            print("Failed to load object from UserDefaults for key \(key): \(error)")
            return nil
        }
    }
}
