//
//  LaunchDetail.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/06.
//

import SwiftUI
import RocketReserverAPI

@Observable final class LaunchDetail {
    let launchID: RocketReserverAPI.ID

    var launch: LaunchDetailsQuery.Data.Launch?
    var isShowingLogin = false

    init(launchID: RocketReserverAPI.ID) {
        self.launchID = launchID
    }

    func loadLaunchDetails() {
        guard launchID != launch?.id else {
            return
        }
        GraphQLClient.shared.apollo.fetch(query: LaunchDetailsQuery(launchId: launchID)) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case .success(let graphQLResult):
                if let launch = graphQLResult.data?.launch {
                    self.launch = launch
                }

                if let errors = graphQLResult.errors {
                    print(errors)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
