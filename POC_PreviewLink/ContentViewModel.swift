//
//  ContentViewModel.swift
//  POC_PreviewLink
//
//  Created by Theo Sementa on 07/01/2025.
//

import Foundation
import SwiftUI
import LinkPresentation
import UniformTypeIdentifiers

final class ContentViewModel: ObservableObject {
    
    @Published var image: UIImage?
    @Published var title: String?
    @Published var url: String?
    
    let previewURL: URL?
    
    init(_ url: String) {
        self.previewURL = URL(string: url)
        fetchMetadata()
    }
}

extension ContentViewModel {
    
    private func fetchMetadata() {
        guard let previewURL else { return }
        let provider = LPMetadataProvider()
        
        Task {
            let metadata = try await provider.startFetchingMetadata(for: previewURL)
            
            image = try await convertToImage(metadata.imageProvider)
            title = metadata.title
            
            url = metadata.url?.host()
        }
    }
    
    private func convertToImage(_ imageProvider: NSItemProvider?) async throws -> UIImage? {
        var image: UIImage?
        
        if let imageProvider {
            let type = String(describing: UTType.image)
            
            if imageProvider.hasItemConformingToTypeIdentifier(type) {
                let item = try await imageProvider.loadItem(forTypeIdentifier: type)
                
                if item is UIImage {
                    image = item as? UIImage
                }
                
                if item is URL {
                    guard let url = item as? URL,
                          let data = try? Data(contentsOf: url) else { return nil }
                    
                    image = UIImage(data: data)
                }
                
                if item is Data {
                    guard let data = item as? Data else { return nil }
                    
                    image = UIImage(data: data)
                }
            }
        }
        
        return image
    }
    
}
