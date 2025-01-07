//
//  ContentView.swift
//  POC_PreviewLink
//
//  Created by Theo Sementa on 07/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewModel = .init(
        "https://apps.apple.com/fr/app/cashflow-suivi-des-d%C3%A9penses/id6450913423"
    )
    
    // MARK: -
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                if let title = viewModel.title {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                
                if let url = viewModel.url {
                    Text(url)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
        }
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(uiColor: .secondarySystemBackground))
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .padding()
    } // body
} // struct

// MARK: - Preview
#Preview {
    ContentView()
}
