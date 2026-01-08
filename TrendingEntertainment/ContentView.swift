//
//  ContentView.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constans.homeString, systemImage: Constans.homeIconString) {
                HomeView()
            }
            Tab(Constans.upcomingString, systemImage: Constans.upcomingIconString) {
                UpcomingView()
            }
            Tab(Constans.searchString, systemImage: Constans.searchIconString) {
                Text(Constans.searchString)
            }
            Tab(Constans.downlaodString, systemImage: Constans.downlaodIconString) {
                Text(Constans.downlaodString)
            }
        }
        .onAppear {
            if let config = ApiConfig.shared {
                print(config.tmdbAPIKey)
                print(config.tmdbBaseURL)
            }
        }
    }
}

#Preview {
    ContentView()
}
