//
//  SongListViewModel.swift
//  SwiftUI-MusicSearchApp
//
//  Created by Kalabishka Ivan on 09.07.2021.
//

import Combine
import Foundation
import SwiftUI
// 11
class SongListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published public private(set) var songs: [SongViewModel] = []
    
    private let dataModel = DataModel()
    private let artworkLoader = ArtworkLoader()
    private var disposables = Set<AnyCancellable>()
    
    init() { // 12
        $searchTerm
            .sink(receiveValue: loadSongs(searchTerm:))
            .store(in: &disposables)
    }
    
    private func loadSongs(searchTerm: String) {
        songs.removeAll()
        artworkLoader.reset()
        
        dataModel.loadSongs(searchTerm: searchTerm) { songs in
            songs.forEach { self.appendSong(song: $0) }
        }
    }
    
    private func appendSong(song: Song) {
        let songViewModel = SongViewModel(song: song)
        
        DispatchQueue.main.async {
            self.songs.append(songViewModel)
        }
        artworkLoader.loadArtwork(forSong: song) { image in
            DispatchQueue.main.async {
                songViewModel.artwork = image
            }
        }
    }
}

// 10
class SongViewModel: Identifiable, ObservableObject {
    let id: Int
    let trackName: String
    let artistName: String
    @Published var artwork: Image?
    
    init(song: Song) {
        self.id = song.id
        self.trackName = song.trackName
        self.artistName = song.artistName
    }
}
