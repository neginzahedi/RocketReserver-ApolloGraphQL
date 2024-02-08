//
//  DetailView.swift
//  RocketReserver-ApolloGraphQL
//
//  Created by Negin Zahedi on 2024-02-08.
//

import SwiftUI
import RocketReserverAPI
import SDWebImageSwiftUI

struct DetailView: View {
    private let placeholderImg = Image("placeholder")
    
    @StateObject private var viewModel: DetailViewModel
    
    init(launchID: RocketReserverAPI.ID) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(launchID: launchID))
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Spacer()
            if let launch = viewModel.launch {
                if let launch = viewModel.launch {
                    HStack(spacing: 10){
                        if let missionPatch = launch.mission?.missionPatch {
                            WebImage(url: URL(string: missionPatch))
                                .resizable()
                                .placeholder(placeholderImg)
                                .indicator(.activity)
                                .scaledToFit()
                                .frame(width: 165, height: 165)
                        }
                    }
                    
                } else {
                    placeholderImg
                        .resizable()
                        .scaledToFit()
                        .frame(width: 165, height: 165)
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        if let missionName = launch.mission?.name{
                            Text("Mission Name:")
                            Text(missionName)
                                .font(.system(size: 24, weight: .bold))
                        }
                    }
                    HStack{
                        if let rocketName = launch.rocket?.name{
                            Text("Rocket Name 🚀:")
                            Text("\(rocketName)")
                                .font(.system(size: 18))
                        }
                    }
                    HStack{
                        if let launchSite = launch.site {
                            Text("Launch Site:")
                            Text(launchSite)
                                .font(.system(size: 14))
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(10)
        .navigationTitle(viewModel.launch?.mission?.name ?? "Mission Name")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            viewModel.loadLaunchDetails()
        }
        .appAlert($viewModel.appAlert)
    }
}

#Preview {
    DetailView(launchID: "110")
}
