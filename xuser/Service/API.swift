//
//  
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//


import Foundation 

enum GetNetworking {
    case getUsers
}

extension GetNetworking: TargetType {
 
    var baseURL: String {
        switch self {
        case .getUsers:
            return "https://jsonplaceholder.typicode.com/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestUser
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestUser
}

protocol TargetType {
 
    var baseURL: String { get }
 
    var method: HTTPMethod { get }
 
    var task: Task { get }
 
    var headers: [String: String]? { get }
}
