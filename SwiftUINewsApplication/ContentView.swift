//
//  ContentView.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            NewsFeedView()
                .navigationTitle("News Feed")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
