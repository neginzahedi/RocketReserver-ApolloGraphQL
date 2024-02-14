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
                    NavigationLink(destination: DetailView(launchID: viewModel.launches[index].id)) {
                        LaunchRow(launch: viewModel.launches[index])
                    }
                }
                if viewModel.lastConnection?.hasMore != false {
                    if viewModel.activeRequest == nil{
                        Button(action: viewModel.loadMoreLaunchesIfTheyExist){
                            Text("tap to load more")
                        }
                    } else {
                        Text("Loading...")
                    }
                }
            }
            .task { // query the server for data
                viewModel.loadMoreLaunchesIfTheyExist()
            }
            .navigationTitle("Rocket launches")
            .appAlert($viewModel.appAlert)
        }
        .notificationView(message: $viewModel.notificationMessage)
    }
}

#Preview {
    ContentView()
}
