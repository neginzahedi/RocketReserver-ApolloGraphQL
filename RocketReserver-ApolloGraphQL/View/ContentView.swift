//
//  ContentView.swift
//  RocketReserver-ApolloGraphQL
//
//  Created by Negin Zahedi on 2024-01-31.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = LaunchListViewModel()
    
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(0..<viewModel.launches.count, id: \.self) { index in
                    LaunchRow(launch: viewModel.launches[index])
                }
            }
            .task { // query the server for data
                viewModel.loadMoreLaunches()
            }
            .navigationTitle("Rocket launches")
            .appAlert($viewModel.appAlert)
        }
    }
}

#Preview {
    ContentView()
}
