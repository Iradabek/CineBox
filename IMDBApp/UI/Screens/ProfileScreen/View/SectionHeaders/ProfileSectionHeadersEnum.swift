//
//  ProfileSectionHeadersEnum.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import UIKit

enum ProfileViewSections: CaseIterable {
    case profile
    case accountSettings
    case helpAndSupport
    case logOut
    
    var sectionTitle: String? {
        switch self {
        case .profile:
            ""
        case .accountSettings:
            "ACCOUNT SETTINGS"
        case .helpAndSupport:
            "HELP & SUPPORT"
        case .logOut:
            ""
        }
    }
}
