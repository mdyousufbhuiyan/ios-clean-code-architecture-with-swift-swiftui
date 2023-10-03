//
//  DestinationDetailsViewModel.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/27/23.
//

import Foundation
import SwiftUI



class DestinationDetailsViewModel: ObservableObject{
    
    
    @Published var isLoading = false
    
    @Published var destinationDetails: DestinationDetails?
    var dispatchWorkItem:DispatchWorkItem?
     var networkManager = NetworkManager()
    
    init(name:String){
    getItems(name: name)
    }
    
    func getItems (name:String) {
        dispatchWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem {[weak self] in
            
            do {

                let request = try Router.destination(name).requestURL()
                self?.networkManager.request(request) {[weak self] (result: Result<DestinationDetails, Error>) in
                    switch result {
                    case .success(let destinationDetails):
                        self?.destinationDetails = destinationDetails
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
