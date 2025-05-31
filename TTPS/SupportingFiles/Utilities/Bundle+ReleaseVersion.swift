//
//  Bundle+ReleaseVersion.swift
//  Asset Management
//
//  Created by Supriyo Dey on 01/01/24.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
