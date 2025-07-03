//
//  NetworkManager.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//


import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    let provider = BaseAPI<GetNetworking>()
    var alertItem: AlertItem?
    
    private init() {}
    
    func getData(completed: @escaping (Result<XuserModel, APError>) -> Void) {
        provider.requestData(target: .getUsers, responseModel: XuserModel.self) { response  in
            switch response {
            case .success(_):
                LoadingView.stopLoading()
                completed(response)
            case .failure(let err):
                print(err)
                LoadingView.stopLoading()
                if let apError = err as? APError {
                    switch apError {
                    case .invalidURL:
                        self.alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        self.alertItem = AlertContext.invalidResponse
                    case .invalidData:
                        self.alertItem = AlertContext.invalidData
                    case .unableToComplete:
                        self.alertItem = AlertContext.unableToComplete
                    }
                } else {
                    self.alertItem = AlertContext.invalidResponse
                }
                completed(response)
                AlertView.showAlert(title: self.alertItem?.title ?? "", message: self.alertItem?.message ?? "")
                return
            }
        }
    }
    
    func downloadImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void ) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
            
        }
        task.resume()
    }
}

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

struct AlertContext {
    static let invalidData = AlertItem(title:"invalidData", message:"invalidData")
    
    static let invalidResponse = AlertItem(title:"invalidResponse", message:"invalidResponse")
    
    static let invalidURL = AlertItem(title:"invalidURL", message:"invalidURL")
    
    static let unableToComplete = AlertItem(title:"unableToComplete", message:"unableToComplete")
    
    static let invalidForm = AlertItem(title:"invalidForm", message:"invalidForm")
    
    static let invalidEmail = AlertItem(title:"invalidEmail", message:"invalidEmail")
    
    static let userSaveSuccess = AlertItem(title:"userSaveSuccess", message:"userSaveSuccess")
    
    static let invalidUserData = AlertItem(title:"invalidUserData", message:"invalidUserData")
    
}
