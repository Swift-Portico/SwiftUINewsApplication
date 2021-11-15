//
//  NewsFeedView.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI

struct NewsFeedView: View {
    
    @ObservedObject var newsFeed = NewsFeed()
    
    var body: some View {
        List(newsFeed){ (article: NewsListItem) in
            NewsFeedListView.init(article: article)
                .onAppear {
                    let _ = print("On Appear called: \(article.id)")
                    newsFeed.loadMoreArticles(currentItem: article)
                }
        }
    }
}

struct NewsFeedListView: View {
    var article: NewsListItem
    var body: some View{
        VStack(alignment: .leading) {
            Text("\(article.title)")
                .font(.headline)
            Text("\(article.author)")
                .font(.subheadline)
        }
        .padding()
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
