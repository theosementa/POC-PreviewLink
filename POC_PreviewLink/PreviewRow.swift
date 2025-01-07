//
//  PreviewRow.swift
//  POC_PreviewLink
//
//  Created by Theo Sementa on 07/01/2025.
//

import SwiftUI

struct PreviewRow: View {
    
    // Builder
    var preview: PreviewLink
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let image = preview.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(
                        width: UIScreen.main.bounds.width / 2 - 24,
                        height: UIScreen.main.bounds.width / 2 - 24
                    )
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let title = preview.title {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
                
                if let url = preview.url {
                    Text(url)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(uiColor: .secondarySystemBackground))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color(uiColor: .secondarySystemFill), lineWidth: 1)
        }
    } // body
} // struct
