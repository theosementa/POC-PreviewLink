//
//  ContentView.swift
//  POC_PreviewLink
//
//  Created by Theo Sementa on 07/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewModel = .init()

    // MARK: -
    var body: some View {
        LazyVGrid(columns: [GridItem(spacing: 16), GridItem(spacing: 16)], spacing: 16) {
            ForEach(viewModel.previews) { preview in
                PreviewRow(preview: preview)
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchMetadata()
        }
    } // body
} // struct

// MARK: - Preview
#Preview {
    ContentView()
}
