//
//  UserListViewModel.swift
//  MVVMBindings
//
//  Created by Linconl Rufino on 18/01/24.
//

import Foundation

struct UserListViewModel {
    var users: Observable<[UserTableViewCellViewModel]> = Observable([])
    
    public func fetchData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return  }
        
        let task =  URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            do {
                let userModels = try JSONDecoder().decode([User].self, from: data)
                    
                users.value = userModels.compactMap({
                    UserTableViewCellViewModel(name: $0.name)
                })
            }
            catch {
                
            }
        }
        task.resume()
    }
}
