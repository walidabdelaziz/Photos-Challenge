//
//  PreferenceManager.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import Foundation
class PreferenceManager {
    
    static func getCachedPhotos() -> [Photos] {
        guard let data = UserDefaults.standard.value(forKey: "cachedPhotos") as? Data,
              let cachedPhotos = try? PropertyListDecoder().decode([Photos].self, from: data) else {
            return []
        }
        return cachedPhotos
    }
    static func saveCachedPhotos(cachedPhotos: [Photos]){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(cachedPhotos), forKey: "cachedPhotos")
    }
}
