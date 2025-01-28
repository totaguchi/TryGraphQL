//
//  SearchView.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/08.
//

import SwiftUI

struct SearchBarView: View {
    @State var searchText: String = ""
    var searchLaunch: (String) -> Void
    var clearSearchLaunch: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")

            TextField("Search", text: $searchText)
                .onSubmit {
                    searchLaunch(searchText)
                }
            
            Button {
                searchText = ""
                clearSearchLaunch()
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundStyle(.black)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .overlay {
            Capsule()
                .stroke(lineWidth: 0.5)
                .shadow(color: .black.opacity(0.4), radius: 2)
        }
        .padding()
        .background(.white)
    }
}

#Preview {
    let searchLaunch: (String) -> Void = { _ in }
    let clearSearchLaunch: () -> Void = {  }
    SearchBarView(searchText: "", searchLaunch: searchLaunch, clearSearchLaunch: clearSearchLaunch)
}
