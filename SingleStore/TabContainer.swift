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
            let _ = print("update")
            TabView(selection: viewStore.binding(get: \.tabSelection, send: {
                print($0,"$$")
                return .updateTabSelection($0)
            })) {
                ForEach(SceneReducer.Tab.allCases) { tab in
                    tab.color
                        .overlay(
                            Text(tab.rawValue.uppercased())
                                .font(.title)
                        )
                        .tag(tab)
                        .tabItem {
                            Text(tab.rawValue)
                        }
                }
            }
        }
    }
}
