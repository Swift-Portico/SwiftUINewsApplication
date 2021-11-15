//
//  URLImageView.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import SwiftUI

struct URLImageView: View {
    
    @ObservedObject var urlImageViewModel: URLImageViewModel
    
    init(urlString: String?){
        self.urlImageViewModel = URLImageViewModel.init(urlStr: urlString)
    }
    
    var body: some View {
        Image(uiImage: (urlImageViewModel.image ?? UIImage.init(systemName: "text.book.closed"))!)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
    }
}

struct URLImageView_Previews: PreviewProvider {
    static var previews: some View {
        URLImageView(urlString: nil)
    }
}
