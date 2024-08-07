//
//  UserDefaultsManager.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 19.07.24.
//

import Foundation

class UserDefaultsManager {
    private enum Keys {
        static let hasCompletedOnboarding = "hasCompletedOnboarding"
    }

    static var hasCompletedOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasCompletedOnboarding)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.hasCompletedOnboarding)
        }
    }
}
