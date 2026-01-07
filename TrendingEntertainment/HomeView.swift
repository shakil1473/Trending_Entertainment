//
//  HomeView.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import SwiftUI

struct HomeView: View {
    var heroTestTitle = Constans.testTitleURL1
    var viewModel = ViewModel()
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView(.vertical) {
                
                switch viewModel.homeStatus {
                case .notStarted:
                    EmptyView()
                case .fetching:
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                case .success:
                    LazyVStack {
                        AsyncImage(url: URL(string: heroTestTitle)!) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .overlay {
                                    LinearGradient(
                                        stops: [Gradient.Stop(color: .clear, location: 0.8),
                                                Gradient.Stop(color: .gradient, location: 1)],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                }
                        }placeholder: {
                            ProgressView()
                        }
                        .frame(width: geo.size.width, height: geo.size.height * 0.85)
                        
                        HStack {
                            Button {
                                
                            } label: {
                                Text(Constans.playString)
                                    .ghostButtonStyle()
                            }
                            
                            Button {
                                
                            } label: {
                                Text(Constans.downlaodString)
                                    .ghostButtonStyle()
                            }
                        }
                        
                        HorizontalListView(header: Constans.trendingMovieString, titles: viewModel.trendingMovies)
                        HorizontalListView(header: Constans.trendingTVShowString, titles: viewModel.trendingTVShows)
                        HorizontalListView(header: Constans.topRatedMovieString, titles: viewModel.topRatedMovies)
                        HorizontalListView(header: Constans.topRatedTVShowString, titles: viewModel.topRatedTVShows)
                    }
                case .failed(let error):
                    Text("Error: \(error)")
                }
            }
            .task {
                await viewModel.getTitles()
            }
        }
    }
}

#Preview {
    HomeView()
}
