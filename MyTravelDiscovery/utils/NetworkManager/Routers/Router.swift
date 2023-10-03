//
//
//  Router.swift
//  MyTravelDiscovery
//
//  Created by Md Yousuf Bhuiyan on 2/27/23.
//
import Foundation


typealias HTTPParameters = [String: Any]?

enum Router {
    
   
    case destination(String)
    case category(String)
    case restaurant(String)
    case search(String)
    
    // MARK: - HTTP Method
    var method: HTTPMethod {
        switch self {
        case  .destination,.category, .restaurant:
            return .get
        case .search(_):
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .destination:
            return "destination"
        case .category:
            return "category"
        case .restaurant:
            return "restaurant"
        case .search(_):
            return ""
        }
    }
    
    var url: URL {
        switch self {
        case .destination, .category,.restaurant:
            guard let url = URL(string: kNetworkEnvironment.baseURL + "travel_discovery/") else {
                fatalError(ErrorMessage.invalidUrl.rawValue)
            }
            return url
        default:
            guard let url = URL(string: kNetworkEnvironment.baseURL) else {
                fatalError(ErrorMessage.invalidUrl.rawValue)
            }
            return url
        
        }
    
    }
    
    
    // MARK: - Parameters
    var parameters: HTTPParameters {
        switch self {
        case .destination(let name),.category(let name):
            return [
                "name": name.lowercased()
//                "page": page,
            ]
        case .restaurant(let id):
            return [
                "id": id
            ]
        default:
            return nil
        }
    }
    
    // MARK: - HttpBody
    var httpBody: HTTPParameters  {
        switch self {
//        case .destination(let name),.category(let name):
//            return [
//                "name": name.lowercased()
////                "page": page,
//            ]
//        case .restaurant(let id):
//            return [
//                "id": id
//            ]
        default:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func requestURL() throws -> URLRequest {
        
        var components = URLComponents(string: url.appendingPathComponent(path).description)!
        components.queryItems = []
        
        if let param = parameters {
            components.queryItems = param.map { (key, value) in
                URLQueryItem(name: key, value: value as? String)
            }
            
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var urlRequest = URLRequest(url: components.url!)
       
        
        if let bodyParms = httpBody {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParms,options: .fragmentsAllowed)
        }
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.cachePolicy = kRequestCachePolicy
        urlRequest.timeoutInterval = kTimeoutInterval
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        return urlRequest
    }
}

