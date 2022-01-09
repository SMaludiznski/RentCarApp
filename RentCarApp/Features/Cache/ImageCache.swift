//
//  ImageCache.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import Foundation
import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    private init() {}
    
    lazy var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.totalCostLimit = 1024 * 1024 * 100
        cache.countLimit = 30
        return cache
    }()
    
    func cache(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func getImageFromCache(_ name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}
