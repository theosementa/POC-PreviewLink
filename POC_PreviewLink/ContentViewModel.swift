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

struct PreviewLink: Identifiable {
    let id: UUID = UUID()
    var image: UIImage?
    let title: String?
    let url: String?
}

final class ContentViewModel: ObservableObject {
    
    @Published var previews: [PreviewLink] = []
    @Published var previewURLs: [String] = [
        "https://apps.apple.com/fr/app/cashflow-suivi-des-d%C3%A9penses/id6450913423",
        "https://split-app.fr/",
        "https://github.com/theosementa"
    ]
    
}

extension ContentViewModel {
    
    func fetchMetadata() {
        for url in previewURLs {
            guard let previewURL = URL(string: url) else { return }
            let provider = LPMetadataProvider()
            
            Task {
                let metadata = try await provider.startFetchingMetadata(for: previewURL)
                
                let image = try await convertToImage(metadata.imageProvider)
                let title = metadata.title
                let url = metadata.url?.host()
                
                previews.append(
                    .init(
                        image: image,
                        title: title,
                        url: url
                    )
                )
            }
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
