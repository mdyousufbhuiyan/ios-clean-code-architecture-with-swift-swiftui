//
//  RestaurantDetailsView.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 3/7/23.
//

import SwiftUI
import Kingfisher

struct RestaurantDetails: Decodable {
    let description: String
    let popularDishes: [Dish]
    let photos: [String]
    let reviews: [Review]
}

struct Review: Decodable, Hashable {
    let user: ReviewUser
    let rating: Int
    let text: String
}

struct ReviewUser: Decodable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage: String
}

struct Dish: Decodable, Hashable {
    let name, price, photo: String
    let numPhotos: Int
}


struct RestaurantDetailsView: View{
    
    @ObservedObject var vm = RestaurantDetailsViewModel()
    
    let restaurant: Restaurant
    var body: some View{
        ScrollView{
            ZStack(alignment: .bottomLeading){
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                
                HStack{
                    VStack(alignment: .leading){
                        
                        Text(restaurant.name)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        HStack(){
                            ForEach(0..<5, id: \.self){num in
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                
                                
                            }
                        }
                    }
                    Spacer()
                    NavigationLink( destination: RestaurantPhotosView(), label: {
                        Text("See more photos")
                            .foregroundColor(.white)
                            .font(.system(size: 14,weight: .regular))
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                    }
                                    
                    )
                }.padding()
            
                
            }
            
            VStack(alignment: .leading,spacing: 8){
                Text("Location & Description")
                    .font(.system(size: 16, weight: .bold))
                
                Text("Tokyo, Japan")
                
                HStack{
                    ForEach(0..<5,id: \.self){num in
                        Image(systemName: "dollarsign.circle.fill")
                        
                    }
                }.foregroundColor(.orange)
                HStack{
                    Spacer()
                }
                
            }.padding(.top)
            .padding(.horizontal)
            
            Text(vm.details?.description ?? "")
            .padding(.top, 8)
            .font(.system(size: 14, weight: .regular))
                .padding(.horizontal)
                .padding(.bottom)
            
            HStack{
                Text("Popular Dishes")
                    .font(.system(size: 20,weight: .bold))
                Spacer()
            }.padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { dish in
                        DishCell(dish: dish)
                    }
                }.padding(.horizontal)
            }
            
            
            if let reviews = vm.details?.reviews {
                ReviewsList(reviews: reviews)
            }
            
        }
        
    }
    
}

struct ReviewsList: View {
    
    let reviews: [Review]
    
    var body: some View {
        HStack {
            Text("Customer Reviews")
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }.padding(.horizontal)
        
//        if let reviews = reviews {
            ForEach(reviews, id: \.self) { review in
                VStack(alignment: .leading) {
                    HStack {
                        KFImage(URL(string: review.user.profileImage))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(review.user.firstName) \(review.user.lastName)")
                                .font(.system(size: 14, weight: .bold))
                            
                            HStack(spacing: 4) {
                                ForEach(0..<review.rating, id: \.self) { num in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.orange)
                                }
                                
                                ForEach(0..<5 - review.rating, id: \.self) { num in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.gray)
                                }
                                
                            }
                            .font(.system(size: 12))
                        }
                        
                        
                        
                        Spacer()
                        Text("Dec 2020")
                            .font(.system(size: 14, weight: .bold))
                        
                    }
                    Text(review.text)
                        .font(.system(size: 14, weight: .regular))
                        
                }.padding(.top)
                .padding(.horizontal)
            }
            
//        }
    }
}

struct DishCell: View{
    let dish: Dish
    var body: some View{
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading){
                KFImage(URL(string: dish.photo))
                    .resizable()
                    .scaledToFill()
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                    .shadow(radius: 2)
                    .padding(.vertical, 2)
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                Text(dish.price)
                    .foregroundColor(.white)
                    .font(.system(size: 13, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.bottom, 4)
                
            }.frame(height: 120)
                .cornerRadius(4)
            
            Text(dish.name)
                .font(.system(size: 14, weight: .bold))
            Text("\(dish.numPhotos) photos")
                .foregroundColor(.gray)
                .font(.system(size: 12, weight: .regular))
        }
    }
}


struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailsView(restaurant: .init(name: "Japan's Finest Tapas", imageName: "tapas"))
            
        }
    }
}
