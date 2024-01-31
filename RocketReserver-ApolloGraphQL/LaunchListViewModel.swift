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
    
}
