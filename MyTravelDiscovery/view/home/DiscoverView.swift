//
//  DiscoverView.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/25/23.
//

import Foundation
import SwiftUI

extension Color {
    static let discoverBackground = Color(.init(white: 0.95, alpha: 1))
    static let defaultBackground = Color("defaultBackground")
}

struct DiscoverView: View{
    @Environment(\.colorScheme) var colorScheme
   
    
    init() {
      
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
            ]
    }
    
    var body: some View{
        
        NavigationView() {
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9882131219, green: 0.6823856831, blue: 0.2509839535, alpha: 1)), Color(#colorLiteral(red: 0.996080339, green: 0.446325405, blue: 0.2697934847, alpha: 1))]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                Color.defaultBackground.offset(y: 400)
                
                ScrollView{
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?")
                        Spacer()
                            
                    }.font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.init(white: 1, alpha: 0.3)))
                    .cornerRadius(10)
                    .padding(16)
                    DiscoverCategoriesView()
                         
                    VStack{
                        PopularDestinationsView()
                            //.colorScheme(.light)
                       PopularRestaurantsView()
                        TrendingCreatorsView()
                        
                    }.background(Color.defaultBackground)
                        .cornerRadius(16)
                        .padding(.top, 32)
                }
                
            }

               // .navigationBarTitle("Discover")
                .navigationTitle("Discover")
                
        }
        
    }
}






struct Discover_Preview: PreviewProvider{
    
    static var previews: some View{
        DiscoverView()
    }
}
