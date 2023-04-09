//
//  TipJarView.swift
//  Memorize21
//
//  Created by Simon Berner on 19.03.23.
//

import SwiftUI
import StoreKit

struct TipJarView: View {

    @EnvironmentObject private var store: TipsStore
    @Binding var showTips: Bool
    @State private var showThanks = false

    var body: some View {

        VStack(spacing: 2) {
            Text("Enjoying the app so far?")
                .font(.system(.title3, design: .rounded).bold())
                .multilineTextAlignment(.center)

            Text("You can tip me if you like!")
                .font(.system(.callout, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 8)

            ForEach(store.items) { item in
                configureProductView(item)
            }
        }
        .padding(16)
        .onChange(of: store.action, perform: { action in
            if action == .successful {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    showThanks.toggle()
                }
                store.reset()
            }
        })
        .alert(isPresented: $store.hasError, error: store.error) { }
        .alert(String("Thanks for the tip! 🙏🏽"), isPresented: $showThanks) {
            Button("Continue", role: .cancel) { showThanks.toggle() }
        }
    }
}

struct TipJarView_Previews: PreviewProvider {
    static var previews: some View {
        TipJarView(showTips: .constant(true))
            .environmentObject(TipsStore())
    }
}

private extension TipJarView {

    private func configureProductView(_ item: Product) -> some View {
        HStack {
            VStack(alignment: .leading,
                   spacing: 2) {
                Text(item.displayName)
                    .font(.system(.title3, design: .rounded).bold())
                Text(item.description)
                    .font(.system(.callout, design: .rounded).weight(.regular))
            }

            Spacer()

            Button(item.displayPrice) {
                Task {
                    await store.purchase(item)
                }
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
        .padding(16)
        .background(Color("tip-cell-background"),
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

private struct ProductsListView: View {

    @EnvironmentObject private var store: TipsStore

    var body: some View {
        ForEach(store.items) { item in
            ProductView(item: item)
        }
    }
}

private struct ProductView: View {

    @EnvironmentObject private var store: TipsStore
    let item: Product

    var body: some View {
        HStack {
            VStack(alignment: .leading,
                   spacing: 3) {
                Text(item.displayName)
                    .font(.system(.title3, design: .rounded).bold())
                Text(item.description)
                    .font(.system(.callout, design: .rounded).weight(.regular))
            }

            Spacer()

            Button(item.displayPrice) {
                Task {
                    await store.purchase(item)
                }
            }
            .tint(.blue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
        }
    }
}
