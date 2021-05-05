//
//  AppUpdate.swift
//  SwiftUtility
//
//  Created by Keyur.
//  Copyright © 2020 Keyur. All rights reserved.
//

import Foundation

enum VersionError: Error {
    case invalidResponse, invalidBundleInfo
}

public func checkForUpdate(_ completion: @escaping () -> Void) {
    DispatchQueue.global(qos: .background).async {
        do {
            let update = try isUpdateAvailable()
            print("update",update)
            if update{
                completion()
                return
            }
        } catch {
            print(error)
        }
    }
}

public func isUpdateAvailable() throws -> Bool {
    guard let info = Bundle.main.infoDictionary,
        let currentVersion = info["CFBundleShortVersionString"] as? String,
        let identifier = info["CFBundleIdentifier"] as? String,
        let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else {
            throw VersionError.invalidBundleInfo
    }
    let data = try Data(contentsOf: url)
    guard let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
        throw VersionError.invalidResponse
    }
    if let result = (json["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
        print("version in app store", version,currentVersion);
        
        return Float(version)! > Float(currentVersion)!
    }
    throw VersionError.invalidResponse
}
