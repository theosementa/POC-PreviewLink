//
//  OnGetWidthModifier.swift
//  POC_PreviewLink
//
//  Created by Theo Sementa on 08/01/2025.
//

import SwiftUI

struct GetWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

struct OnGetWidthViewModifier: ViewModifier {
    
    let completion: (CGFloat) -> Void
    
    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader {
                    Color.clear
                        .preference(
                            key: GetWidthKey.self,
                            value: $0.frame(in: .local).size.width
                        )
                }
            }
            .onPreferenceChange(GetWidthKey.self) {
                completion($0)
            }
    }
}

extension View {
    func onGetWidth(perform completion: @escaping (CGFloat) -> Void) -> some View {
        modifier(OnGetWidthViewModifier(completion: completion))
    }
}
