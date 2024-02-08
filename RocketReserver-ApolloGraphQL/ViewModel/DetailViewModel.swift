//
//  DetailViewModel.swift
//  RocketReserver-ApolloGraphQL
//
//  Created by Negin Zahedi on 2024-02-08.
//

import Foundation
import RocketReserverAPI
import KeychainSwift

class DetailViewModel: ObservableObject {
    
    let launchID: RocketReserverAPI.ID
    
    @Published var launch: LaunchDetailsQuery.Data.Launch?
    @Published var appAlert: AppAlert?
    @Published var isShowingLogin = false
    
    init(launchID: RocketReserverAPI.ID) {
        self.launchID = launchID
    }
    
    func loadLaunchDetails() {
        guard launchID != launch?.id else {
            return
        }
        
        Network.shared.apollo.fetch(query: LaunchDetailsQuery(id: launchID)) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let graphQLResult):
                if let launch = graphQLResult.data?.launch {
                    self.launch = launch
                }
                
                if let errors = graphQLResult.errors {
                    self.appAlert = .errors(errors: errors)
                }
            case .failure(let error):
                self.appAlert = .errors(errors: [error])
            }
        }
    }
    
    func bookOrCancel() {
        print(isShowingLogin)
        
        guard self.isLoggedIn() else {
            isShowingLogin = true
            return
        }
        // TODO
    }
    
    private func isLoggedIn() -> Bool {
        let keychain = KeychainSwift()
        return keychain.get(LoginView.loginKeychainKey) != nil
    }
}
