//
//  SwiftUI_MusicSearchAppApp.swift
//  SwiftUI-MusicSearchApp
//
//  Created by Kalabishka Ivan on 08.07.2021.
//

import SwiftUI

@main
struct SwiftUI_MusicSearchAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: SongListViewModel())
        }
    }
}
