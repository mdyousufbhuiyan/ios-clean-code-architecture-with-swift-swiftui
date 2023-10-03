//
//  RestaurantDetailsViewModel.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 3/7/23.
//

import Foundation
class RestaurantDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    
    @Published var details: RestaurantDetails?
    
    var dispatchWorkItem:DispatchWorkItem?
     var networkManager = NetworkManager()
    
    
    init() {
        
        getRestaurant(id: "0")
    }
    
    func getRestaurant(id:String){
        dispatchWorkItem?.cancel()
//        if places.isEmpty {
//            self.places = []
//            return
//        }
        isLoading=true
        let requestWorkItem = DispatchWorkItem {[weak self] in
            do {
                let request = try Router.restaurant(id).requestURL()
                self?.networkManager.request(request) {[weak self] (result: Result<RestaurantDetails, Error>) in
                    self?.isLoading = false
                    switch result {
                    case .success(let details):
//                        if Int(page) == 1 {
//                            self?.repoItems = []
//                        }
                        self?.details = details
                      //  self?.repoItems += repositoryModelBase.items ?? []
                    case .failure(let error):
                       
                        if let error = error as? NetworkError {
                            let message = ErrorMapper(error: error).message
                          
                            print(message)
                        } else {
                            print(error)
                        }
                    }

                }
            } catch {
                print("Errors: \(error)")
            }
        }
        
        dispatchWorkItem = requestWorkItem
        DispatchQueue.global().asyncAfter(deadline: .now() + .milliseconds(400), execute: dispatchWorkItem!)
    }
    
}
