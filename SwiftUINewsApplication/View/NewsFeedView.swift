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
        NavigationView {
            List(newsFeedVM){ (article: NewsListItem) in
                NavigationLink.init(destination: NewsFeedURLView.init(article: article)){
                    NewsFeedListView.init(article: article)
                        .onAppear {
                            newsFeedVM.loadMoreArticles(currentItem: article)
                        }
                }
            }
            .navigationBarTitle("News Feed")
        }
    }
}

struct NewsFeedURLView: View {
    var article: NewsListItem
    var body: some View {
        ZStack{
            if(article.url != nil){
                NewsFeedWebView.init(urlToDispaly: URL(string: article.url!)!)
                    .navigationTitle(article.title!)
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
