//
//  Network.swift
//  RocketReserver-ApolloGraphQL
//
//  Created by Negin Zahedi on 2024-01-31.
//

import Foundation
import Apollo

class Network {
  static let shared = Network()

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
}
