//
//  NewsFeedModel.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI

class NewsFeed: ObservableObject, RandomAccessCollection {
    typealias Element = NewsListItem
    
    @Published var newsListItem = [NewsListItem]()
    
    init(){
        self.loadMoreArticles()
    }
    
    var startIndex: Int { return newsListItem.startIndex }
    
    var endIndex: Int { return  newsListItem.endIndex }
    
    var nextPageToLoad: Int = 1
    
    var isCurrentlyProcessing: Bool = false
    
    subscript(position: Index) -> NewsListItem {
        return newsListItem[position]
    }
    
    private let baseURL = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=f7c59e261cc04dd4b317379bd49485d0&page="
    
    func loadMoreArticles(currentItem: NewsListItem? = nil) {
        if(!shouldLoadMoreData(currentItem: currentItem)){
            return
        }
        isCurrentlyProcessing = true
        guard let url = URL.init(string: "\(baseURL)\(nextPageToLoad)") else { return }
        let task = URLSession.shared.dataTask(with: url, completionHandler: parseArticlesFromResponse)
        task.resume()
    }
    
    private func shouldLoadMoreData(currentItem: NewsListItem? = nil) -> Bool {
        if(isCurrentlyProcessing){
            return false
        }
        guard let currentItem = currentItem else {
            return true
        }
        
        for n in (self.newsListItem.count - 4)...(self.newsListItem.count - 1){
            if(n > 0 && currentItem.id == self.newsListItem[n].id){
                return true
            }
        }

        return false
    }
    
    private func parseArticlesFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let err = error {
            print("Error found:\(err)")
            self.isCurrentlyProcessing = false
            return
        }
        
        guard let data = data else {
            print("No data found")
            self.isCurrentlyProcessing = false
            return
        }
        
        if let newsArticles = self.parseArticlesFromData(data: data) {
            DispatchQueue.main.async {
                print("** Response received **")
                self.newsListItem.append(contentsOf: newsArticles)
                self.nextPageToLoad += 1
                self.isCurrentlyProcessing = false
            }
        }
    }
    
    private func parseArticlesFromData(data: Data) -> [NewsListItem]? {
        let jsonObject  = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        let topLevelMap = jsonObject as! [String: Any]
        guard let status = topLevelMap["status"] as? String else {
            print("*** Status was not OK***")
            return nil
        }
        if(status == "ok"){
            if let articles = topLevelMap["articles"] as? [[String: Any]] {
                var newArticles = [NewsListItem]()
                for article in articles {
                    guard let author = article["author"] as? String else{
                        continue
                    }
                    
                    guard let title = article["title"] as? String else {
                        continue
                    }
                    newArticles.append(NewsListItem.init(author: author, title: title))
                }
                return newArticles
            }
        }
        return nil
    }
    
}

class NewsListItem: Identifiable {
    var id = UUID()
    var author: String
    var title: String
    
    init(id: UUID = UUID(), author: String, title: String) {
        self.id = id
        self.author = author
        self.title = title
    }
}
