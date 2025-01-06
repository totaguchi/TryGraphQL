//
//  LaunchDetailView.swift
//  TryGraphQL
//
//  Created by 田口友暉 on 2025/01/06.
//

import SwiftUI
import SDWebImageSwiftUI
import RocketReserverAPI

struct LaunchDetailView: View {
    @State private var launchDetail: LaunchDetail!
    
    init(launchID: RocketReserverAPI.ID) {
        _launchDetail = State(wrappedValue: LaunchDetail(launchID: launchID))
    }

    var body: some View {
        VStack {
            if let launch = launchDetail.launch {
                HStack(spacing: 10) {
                    if let missionPath = launch.mission?.missionPatch {
                        WebImage(url: URL(string: missionPath)) { image in
                            image.resizable()
                        }
                        placeholder: {
                            Rectangle().foregroundColor(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        .indicator(.activity)
                        .scaledToFit()
                        .frame(width: 165, height: 165)
                    } else {
                        Rectangle().foregroundColor(.gray).frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        if let missionName = launch.mission?.name {
                            Text(missionName)
                                .font(.system(size: 24, weight: .bold))
                        }
                        
                        if let rocketName = launch.rocket?.name {
                            Text("🚀 \(rocketName)")
                                .font(.system(size: 18))
                        }
                        
                        if let launchSite = launch.site {
                            Text(launchSite)
                                .font(.system(size: 14))
                        }
                    }
                    
                    Spacer()
                }
                
                if launch.isBooked {
                    Button {
                        
                    } label: {
                        Text("Cancel Trip")
                            .foregroundStyle(.black)
                            .frame(width: 150, height: 50)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                } else {
                    Button {
                        
                    } label: {
                        Text("Book Trip")
                            .foregroundStyle(.black)
                            .frame(width: 150, height: 50)
                            .background(.green)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
    
            Spacer()
        }
        .padding(10)
        .navigationTitle(launchDetail.launch?.mission?.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            launchDetail.loadLaunchDetails()
        }
//        .sheet(isPresented: $launchDetail.isShowingLogin) {
//            LoginView(isPresented:$launchDetail.isShowingLogin)
//        }
    }
}

#Preview {
    LaunchDetailView(launchID: "110")
}
