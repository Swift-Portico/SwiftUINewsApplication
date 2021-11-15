//
//  NewsFeedView.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI

struct NewsFeedView: View {
    
    @ObservedObject var newsFeedVM = NewsFeedViewModel()
    
    var body: some View {
        List(newsFeedVM){ (article: NewsListItem) in
            NewsFeedListView.init(article: article)
                .onAppear {
                    newsFeedVM.loadMoreArticles(currentItem: article)
                }
        }
    }
}

struct NewsFeedListView: View {
    var article: NewsListItem
    var body: some View {
        HStack {
            URLImageView(urlString: article.urlToImage)
            VStack(alignment: .leading) {
                Text("\(article.title ?? "---")")
                    .font(.headline)
                Text("\(article.author ?? "No Author")")
                    .font(.subheadline)
            }
            .padding()
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
