//
//  DiscoverCategoriesView.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/25/23.
//

import Foundation
import SwiftUI



struct DiscoverCategoriesView:View{
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Live Events", imageName: "music.mic"),
        .init(name: "Food", imageName: "tray.fill"),
        .init(name: "History", imageName: "books.vertical.fill")
    ]
    
    var body: some View{
        VStack{
            ScrollView(.horizontal){
                HStack(alignment: .top, spacing: 14){
                    ForEach(categories, id: \.self){category in
                        
                        NavigationLink(destination: {
                            NavigationLazyView(
                                CategoryDetailsView(name: category.name)
                            )
                        } , label: {
                            VStack(spacing: 8) {
                                Image(systemName: category.imageName)
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 0.5059075952, blue: 0.2313886285, alpha: 1)))
                                    .frame(width: 64, height: 64)
                                    .clipped()
                                    .background(Color.white)
                                    .cornerRadius(64)
                                Text(category.name)
                                    .font(.system(size: 12, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }.frame(width: 68)
                        }
                        )
                        
                        
                        
                    }
                    
                }.padding(.horizontal)
            }
        }
    }
}

struct categoryPreviewProvider: PreviewProvider{
    
    static var previews: some View{
        DiscoverView()
    }
}



