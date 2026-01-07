//
//  Constans.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import Foundation
import SwiftUI

struct Constans {
    static let homeString = "Home"
    static let upcomingString = "Upcoming"
    static let searchString = "Search"
    static let downlaodString = "Download"
    static let playString = "Play"
    static let trendingMovieString = "Treding Movies"
    static let trendingTVShowString = "Treding TV Shows"
    static let topRatedMovieString = "Top Rated Movies"
    static let topRatedTVShowString = "Top Rated TV Shows"
    
    static let homeIconString = "house"
    static let upcomingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downlaodIconString = "arrow.down.to.line"
    
    static let testTitleURL1 = "https://image.tmdb.org/t/p/w1280/bYzj5KbPgN249rCoNTyHuC8gDcH.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w600_and_h900_face/c15BtJxCXMrISLVmysdsnZUPQft.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w600_and_h900_face/pHpq9yNUIo6aDoCXEBzjSolywgz.jpg"
    static let testTitleURL4 = "https://image.tmdb.org/t/p/w600_and_h900_face/9hLo3uSeGx6vDtnOPQcq7sVBzsL.jpg"
    static let testTitleURL5 = "https://image.tmdb.org/t/p/w600_and_h900_face/uOOtwVbSr4QDjAGIifLDwpb2Pdl.jpg"
    
    static let posterURLStart = "https://image.tmdb.org/t/p/w600_and_h900_face"
    
    static func addPosterPath(to titles: inout[Title]) {
        for index in titles.indices {
            if let path = titles[index].posterPath {
                titles[index].posterPath = Constans.posterURLStart + path
            }
        }
    }
}


extension Text {
    func ghostButtonStyle() -> some View {
        self
            .frame(width: 100, height: 50)
            .foregroundStyle(.buttonText)
            .bold()
            .background{
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(.buttonBorder, lineWidth: 5)
            }
    }
}
