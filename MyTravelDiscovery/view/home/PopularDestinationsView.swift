//
//  PopularDestinationsView.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/26/23.
//

import Foundation
import SwiftUI
import MapKit


struct PopularDestinationsView: View{
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.855014, longitude: 2.341231),
        .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.67988, longitude: 139.7695),
        .init(name: "New York", country: "US", imageName: "new_york", latitude: 40.71592, longitude: -74.0055),
    ]
    
    var body: some View{
        VStack{
            HStack {
                Text("Popular destinations")
                    .font(.system(size: 14, weight: .semibold))
                
                Spacer()
                Text("See all")
                    .font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal)
            .padding(.top)
           // .foregroundColor(Color.defaultBackground)
            
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(destinations,id: \.self) { destination in
                        NavigationLink{
                            
                        
                           NavigationLazyView(PopularDestinationDetailsView(destination: destination))
                        } label: {
                            PopularDestinationTile(destination: destination)
                                .padding(.bottom)
                        }
                    }
                }
            }
            
            
            
        }
        
    }
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .clipped()
                .cornerRadius(4)
                .padding(.horizontal, 6)
                .padding(.vertical, 6)
            
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .foregroundColor(Color(.label))
            
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
        }
        .asTitle()
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularDestinationsView()
          //  .colorScheme(.light)
        
//        NavigationView {
//            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
////            PopularDestinationDetailsView(destination: .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.679693, longitude: 139.771913))
//        }
        DiscoverView()
    }
}
