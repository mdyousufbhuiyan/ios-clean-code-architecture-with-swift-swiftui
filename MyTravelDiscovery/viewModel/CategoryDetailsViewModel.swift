//
//  CategoryDetailsViewModel.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/28/23.
//

import Foundation
import Kingfisher
import SDWebImageSwiftUI


class CategoryDetailsViewModel: ObservableObject{
    
    @Published var isLoading = false
    @Published var places = [Place]()
    @Published var errorMessage = ""
    var dispatchWorkItem:DispatchWorkItem?
     var networkManager = NetworkManager()
    
    init(name: String){
        getDetails(name: name)
    }
    func getDetails (name:String) {
        dispatchWorkItem?.cancel()
        self.places = []
        isLoading=true
        let requestWorkItem = DispatchWorkItem {[weak self] in
            do {
                let request = try Router.category(name).requestURL()
                self?.networkManager.request(request) {[weak self] (result: Result<[Place], Error>) in
                    self?.isLoading = false
                    switch result {
                    case .success(let places):
//                        if Int(page) == 1 {
//                            self?.repoItems = []
//                        }
                        self?.places = places
                      //  self?.repoItems += repositoryModelBase.items ?? []
                    case .failure(let error):
                       
                        if let error = error as? NetworkError {
                            let message = ErrorMapper(error: error).message
                          
                            self?.errorMessage = "Bad status: \(message)"
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

