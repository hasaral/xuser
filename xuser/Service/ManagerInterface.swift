//
//
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//


import Foundation

protocol UserManagerInterface {
    var dataModel : XuserModel { get }
    func fetchData(completion: @escaping (Result<XuserModel, APError>) -> Void)
}

final class UserManager: UserManagerInterface {
    
    static let shared = UserManager()
    
    var dataModel: XuserModel = []
    
    func fetchData(completion: @escaping (Result<XuserModel, APError>) -> Void) {
        getData() { (res) in
            switch res {
            case .success(_):
                DispatchQueue.main.async {
                    completion(.success(self.dataModel))
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    
    private func getData(completed: @escaping (Result<XuserModel, APError>) -> Void) {
        NetworkManager.shared.getData(completed: { result in
            switch result {
            case .success(let res):
                self.dataModel = res
                completed(result)
            case .failure(_):
                completed(result)
            }
        })
    }
    
}
