//
//  URLImageViewModel.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI

class URLImageViewModel: ObservableObject {
    
    @Published var image: UIImage?
    
    private var urlString: String?
    
    var imageCache = ImageCache.initialization()
    
    init(urlStr: String?) {
        self.urlString = urlStr
        self.loadImage()
    }
    
    func loadImage() {
        
        if(loadFromImageCache()){
            print("Cache Hit")
            return
        }
        print("Cache Miss, Try...baba..")
        self.loadImageFromURL()
    }
    
    private func loadFromImageCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cachedImage = imageCache.getImageCache(forKey: urlString) else {
            return false
        }
        
        self.image = cachedImage
        
        return true
    }
    
    private func loadImageFromURL() {
        guard let urlString = urlString,let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse)
        task.resume()
    }
    
    private func getImageFromResponse(
        data: Data?,
        response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error found:\(error!.localizedDescription)")
            return
        }
        
        guard let data = data else {
            print("Data not found")
            return
        }
        
        DispatchQueue.main.async {
            guard let downloadedImage = UIImage(data: data) else {
                print("Downloaded Image not found")
                return
            }
            self.imageCache.setImageCache(forKey: self.urlString!, image: downloadedImage)
            self.image = downloadedImage
        }
    }
    
}
