//
//  FilmListView.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/04.
//

import SwiftUI
import RocketReserverAPI

struct LaunchListView: View {
    @State private var launchList = LaunchList()
    var body: some View {
        NavigationStack {
            List {
                ForEach(launchList.launches, id: \.self) { launch in
                    NavigationLink(value: launch) {
                        LaunchRow(launch: launch)
                    }
                }
                if launchList.lastConnection?.hasMore != false {
                    if launchList.activeRequest == nil {
                        Button {
                            launchList.loadMoreLaunchesIfTheyExist()
                        } label: {
                            Text("Tap to load more")
                        }
                    } else {
                        Text("Loading...")
                    }
                }
            }
            .onAppear {
                launchList.loadMoreLaunchesIfTheyExist()
            }
            .navigationDestination(for: LaunchListQuery.Data.Launches.Launch.self) { launch in
                LaunchDetailView(launchID: launch.id)
            }
        }
    }
}

#Preview {
    LaunchListView()
}
