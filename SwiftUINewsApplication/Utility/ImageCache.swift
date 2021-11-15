//
//  ImageCache.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import UIKit

class ImageCache: NSObject {
    var cache = NSCache<NSString, UIImage>()
    
    func getImageCache(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString.init(string: key))
    }
    
    func setImageCache(forKey key: String, image: UIImage) {
        cache.setObject(image, forKey: NSString.init(string: key))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func initialization() -> ImageCache {
        return imageCache
    }
}
