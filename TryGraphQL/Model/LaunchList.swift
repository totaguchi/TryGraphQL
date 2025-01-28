//
//  AllFilms.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/04.
//
import SwiftUI
import RocketReserverAPI
import Apollo

@Observable final class LaunchList {
    let id = UUID()
    var launches = [LaunchListQuery.Data.Launches.Launch]()
    var lastConnection: LaunchListQuery.Data.Launches?
    var activeRequest: Cancellable?
    var isSearching: Bool = false
    var searchText: String = ""
    var displayLaunches: [LaunchListQuery.Data.Launches.Launch] {
        return isSearching ? launches.filter { $0.site?.contains(searchText) ?? false } : launches
    }
    
    private func loadMoreLaunches(from cursor: String?) {
        self.activeRequest =  GraphQLClient.shared.apollo.fetch(query: LaunchListQuery(cursor: cursor ?? nil)) { [weak self] result in
            guard let self = self else {
                return
            }
            self.activeRequest = nil
            switch result {
            case .success(let graphQLResult):
              if let launchConnection = graphQLResult.data?.launches {
                  self.lastConnection = launchConnection
                  self.launches.append(contentsOf: launchConnection.launches.compactMap({ $0 }))
                    print(launches)
              } else if let errors = graphQLResult.errors {
                // GraphQL errors
                print(errors)
              }
            case .failure(let error):
              // Network or response format errors
              print(error)
            }
        }
    }

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
}
