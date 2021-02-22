//
//  AlbumImageView.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/22/21.
//

import SwiftUI

struct AlbumImageView: View {
    @ObservedObject var artistViewModel: ArtistViewModel
    
    var body: some View {
        Image(uiImage: artistViewModel.image)
            .resizable()
            .frame(width:100, height:100)
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .shadow(radius: 6)
    }
}
