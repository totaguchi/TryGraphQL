//
//  GraphQLClient.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/04.
//

import Apollo
import Foundation

final class GraphQLClient {
    public static let shared = GraphQLClient()

    let apollo = {
        return ApolloClient(url: URL(string: "https://apollo-fullstack-tutorial.herokuapp.com/graphql")!)
    }()
}
