//
//  LaunchListViewModel.swift
//  RocketReserver-ApolloGraphQL
//
//  Created by Negin Zahedi on 2024-01-31.
//

import Foundation
import SwiftUI
import Apollo
import RocketReserverAPI

class LaunchListViewModel: ObservableObject {
    @Published var launches = [LaunchListQuery.Data.Launches.Launch]()
    @Published var appAlert: AppAlert?

    init() {
        // Test query to check communication with server
          /*
           Network.shared.apollo.fetch(query: LaunchListQuery()) { result in
              switch result {
              case .success(let graphQLResult):
                  print("Success! Result: \(graphQLResult)")
              case .failure(let error):
                  print("Failure! Error: \(error)")
              }
          }
        */
        
        // TODO (Section 13 - https://www.apollographql.com/docs/ios/tutorial/tutorial-subscriptions#use-your-subscription)

    }
    
    func loadMoreLaunches(){
        Network.shared.apollo.fetch(query: LaunchListQuery()) { [weak self] result in
            guard let self = self else {
                return
            }
            
            // GraphQLResult has both a data property and an errors property. This is because GraphQL allows partial data to be returned if it's non-null.
            switch result {
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.launches {
                    self.launches.append(contentsOf: launchConnection.launches.compactMap({ $0 }))
                }

                if let errors = graphQLResult.errors {
                    self.appAlert = .errors(errors: errors)
                }
            case .failure(let error):
                self.appAlert = .errors(errors: [error])
            }
        }
    }
}
