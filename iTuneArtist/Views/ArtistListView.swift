//
//  ArtistListView.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import SwiftUI
import Combine

struct ArtistListView: View {
    
    // Observe parent viewController's property artistViewModel change
    @ObservedObject var viewController: ViewController
    
    var body: some View {
        List(viewController.artistViewModels) { artistViewModel in
            HStack(spacing: 10) {
                AlbumImageView(artistViewModel: artistViewModel)
                VStack(alignment: .leading) {
                    Text(artistViewModel.trackName)
                        .font(.system(.headline, design: .rounded))
                        .lineLimit(2)
                    Text(artistViewModel.name)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .lineLimit(2)
                        .padding(.bottom, 3)
                    
                    
                    Text(artistViewModel.price)
                        .font(.callout)
                        .fontWeight(.black)
                    HStack {
                        Text(artistViewModel.releaseDate)
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .fontWeight(.medium)
                        Text(artistViewModel.genre)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    
                    
                }
                
            }
            .frame(height:120)
        }
    }
}


