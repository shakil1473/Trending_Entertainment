//
//  HomeView.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import SwiftUI

struct HomeView: View {
    var viewModel = ViewModel()
    @State private var titleDetailPath = NavigationPath()
    
    
    var body: some View {
        NavigationStack(path: $titleDetailPath) {
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
                            AsyncImage(url: URL(string: viewModel.heroTitle.posterPath ?? "")!) { image in
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
                                    titleDetailPath.append(viewModel.heroTitle)
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
                            
                            HorizontalListView(header: Constans.trendingMovieString, titles: viewModel.trendingMovies) { title in
                                titleDetailPath.append(title)
                            }
                            
                            HorizontalListView(header: Constans.trendingTVShowString, titles: viewModel.trendingTVShows) { title in
                                titleDetailPath.append(title)
                            }
                            
                            HorizontalListView(header: Constans.topRatedMovieString, titles: viewModel.topRatedMovies) { title in
                                titleDetailPath.append(title)
                            }
                            
                            HorizontalListView(header: Constans.topRatedTVShowString, titles: viewModel.topRatedTVShows) { title in
                                titleDetailPath.append(title)
                            }
                        }
                    case .failed(let error):
                        Text("Error: \(error)")
                    }
                }
                .task {
                    await viewModel.getTitles()
                }
                .navigationDestination(for: Title.self) { title in
                    TitleDetailView(title: title)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
