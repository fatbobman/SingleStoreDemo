//
//  TabContainer.swift
//  SingleStore
//
//  Created by Yang Xu on 2023/4/14.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct TabContainer: View {
    let store: StoreOf<SceneReducer>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(get: \.tabSelection, send: { .updateTabSelection($0) })) {
                ForEach(SceneReducer.Tab.allCases) { tab in
                    tab.color
                        .overlay(
                            SubView(title: tab.rawValue, action: { viewStore.send(.hitButtonTapped, animation: .default) })
                        )
                        .tag(tab)
                        .tabItem {
                            Text(tab.rawValue.uppercased())
                        }
                }
            }
        }
    }
}

struct SubView: View {
    let title: String
    let action: () -> Void
    var body: some View {
        VStack {
            Text(title.uppercased())
                .font(.title)
            Button {
                action()
            } label: {
                Text("Hit Me".uppercased())
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
