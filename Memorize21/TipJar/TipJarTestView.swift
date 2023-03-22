//
//  TipJarTestView.swift
//  Memorize21
//
//  Created by Simon Berner on 22.03.23.
//

import SwiftUI
import StoreKit

struct TipJarTestView: View {
    @State private var myProduct: Product?

    var body: some View {
        VStack {
            Text("Product Info")
            Text(myProduct?.displayName ?? "")
            Text(myProduct?.description ?? "")
            Text(myProduct?.displayPrice ?? "")
            Text(myProduct?.price.description ?? "")
        }
        .task {
            // Get products from the TipsStoreKitConfiguration file
            myProduct = try? await Product.products(for: ["dev.simonberner.Memorize21.tinyTip"]).first
        }
    }
}

struct TipJarTestView_Previews: PreviewProvider {
    static var previews: some View {
        TipJarTestView()
    }
}
