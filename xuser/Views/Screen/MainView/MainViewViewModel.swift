//
//  MainViewViewModel.swift
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//

import Foundation

final class MainViewViewModel: ObservableObject {
    
    let dataManager: UserManagerInterface
    @Published var userModel: XuserModel = []
    
    init(manager:UserManagerInterface = UserManager.shared ) {
        self.dataManager = manager
    }
    
    func getUsers() {
        self.dataManager.fetchData { [weak self] response in
            switch response {
            case .success(let data):
                self?.userModel = data
            case .failure(let err):
                print(err)
            }
        }
    }
}
