//
//  TabContainer.swift
//  SingleStore
//
//  Created by Yang Xu on 2023/4/14.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct TabContainer:View {
    let store:StoreOf<SceneReducer>
    var body: some View {
        WithViewStore(store,observe: {$0}){ viewStore in
            TabView(selection: viewStore.binding(get: \.tabSelection, send: {.updateTabSelection($0)})){
                ForEach(SceneReducer.Tab.allCases){ tab in
                    Text(tab.rawValue)
                        .font(.title)
                        .tag(tab)
                        .tabItem{
                            Text(tab.rawValue)
                        }
                }
            }
        }
    }
}
