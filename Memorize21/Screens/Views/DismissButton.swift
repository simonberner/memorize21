//
//  DismissButton.swift
//  Memorize21
//
//  Created by Simon Berner on 29.03.23.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss

    private let buttonIcon = "xmark"

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: buttonIcon)
                .foregroundColor(.red)
        }
    }
}

struct DismissButton_Previews: PreviewProvider {
    static var previews: some View {
        DismissButton()
        DismissButton()
            .environment(\.colorScheme, .dark)
    }
}
