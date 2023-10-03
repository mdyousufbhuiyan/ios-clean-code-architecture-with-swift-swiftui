//
//  PopularDestinationDetailsView.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 3/1/23.
//

import Foundation
import SwiftUI
import MapKit


struct PopularDestinationDetailsView: View {
    
    @ObservedObject var vm: DestinationDetailsViewModel
    let destination: Destination
    
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = true

    
    init(destination: Destination){
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        self.vm = .init(name: destination.name)
    }
    let imageUrlStrings = [
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531"
    ]
    
    var body: some View{
        ScrollView{
            
            if let photos = vm.destinationDetails?.photos {
                DestinationHeaderContainer(imageUrlStrings: photos)
                    .frame(height: 350)
                
                //            Image(destination.imageName)
                //                .resizable()
                //                .scaledToFill()
                //                .clipped()
                            
                
                VStack(alignment: .leading){
                  
                    Text(destination.name)
                        .font(.system(size: 20,weight: .bold))
                    
                    Text(destination.country)
                        .font(.system(size: 20))
                    
                    
                  HStack{
                      ForEach(0..<5,id: \.self){num in
                          
                          Image(systemName: "star.fill")
                              .foregroundColor(.orange)
                             
                      }
                  }.padding(.top,2)
                
                    HStack{
                        Text(vm.destinationDetails?.description ?? "")
                            .padding(.top, 4)
                            .font(.system(size: 14))
                        Spacer()
                    }
                    
                    
                    HStack{
                        Spacer()
                    }
                    
                }.padding(.horizontal)
                
                HStack{
                    Text("Location")
                        .font(.system(size: 18,weight: .semibold))
                    Spacer()
                    Button(action: {
                        _isShowingAttractions.wrappedValue.toggle()
                    }, label: {
                        Text("\(isShowingAttractions ? "HIde" : "Show") Attractions")
                            .font(.system(size: 12, weight: .semibold))
                    })
                    Toggle("",isOn: $isShowingAttractions)
                        .labelsHidden()
                    
                }.padding(.horizontal)
                
                
                Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
    //                MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude), tint: .blue)
                    MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                        CustomMapAnnotation(attraction: attraction)
                    }
                }.frame(height: 200)
                
                
            }
          
        }
        .navigationBarTitle(destination.name, displayMode: .inline)
    }
    
    let attractions: [Attraction] = [
        .init(name: "Eiffel Tower", imageName: "eiffel_tower", latitude: 48.858605, longitude: 2.2946),
        .init(name: "Champs-Elysees", imageName: "new_york", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "art2", latitude: 48.860288, longitude: 2.337789)
    ]
    
    
}
struct Attraction: Identifiable {
    let id = UUID().uuidString
    
    let name, imageName: String
    let latitude, longitude: Double
}

struct CustomMapAnnotation: View {
    
    let attraction: Attraction
    
    var body: some View {
        VStack {
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 6)
                .padding(.vertical, 4)
                .background(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                .foregroundColor(.white)
//                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .cornerRadius(4)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                )
            
        }.shadow(radius: 5)
    }
}

struct PopularDestinationDetailsView_Preview: PreviewProvider{
    static var previews: some View {
        PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
    }
}
