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
    @Published var lastConnection: LaunchListQuery.Data.Launches? // most recently received LaunchConnection object
    @Published var activeRequest: Cancellable?  // most recent request
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
    
    // check if there are any launches to load before attempting to load them
    func loadMoreLaunchesIfTheyExist() {
        guard let connection = self.lastConnection else {
            self.loadMoreLaunches(from: nil)
            return
        }
        
        guard connection.hasMore else {
            return
        }
        
        self.loadMoreLaunches(from: connection.cursor)
    }
    
    func loadMoreLaunches(from cursor: String?){
        self.activeRequest = Network.shared.apollo.fetch(query: LaunchListQuery(cursor: cursor ?? .null)) { [weak self] result in
            guard let self = self else {
                return
            }
            
            self.activeRequest = nil
            
            // GraphQLResult has both a data property and an errors property. This is because GraphQL allows partial data to be returned if it's non-null.
            switch result {
            case .success(let graphQLResult):
                if let launchConnection = graphQLResult.data?.launches {
                    self.lastConnection = lastConnection
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
