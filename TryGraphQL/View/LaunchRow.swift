//
//  LaunchRow.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/06.
//

import SwiftUI
import RocketReserverAPI
import SDWebImageSwiftUI

struct LaunchRow: View {
    let launch: LaunchListQuery.Data.Launches.Launch

    var body: some View {
        HStack {
            if let missionPath = launch.mission?.missionPatch {
                WebImage(url: URL(string: missionPath)) { image in
                    image.resizable()
                }
                placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                .indicator(.activity)
                .scaledToFit()
                .frame(width: 50, height: 50)
            } else {
                Rectangle().foregroundColor(.gray).frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            VStack(alignment: .leading) {
                Text("Mission Name")
                    .foregroundStyle(.black)
                Text(launch.site ?? "Launch Site")
                    .font(.system(size: 14))
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
//    LaunchRow(launch: launchList.launches[0])
}
