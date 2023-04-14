//
//  ContentView.swift
//  SingleStore
//
//  Created by Yang Xu on 2023/4/14.
//

import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<AppReducer>
    @State var sceneID: UUID?
    var body: some View {
        VStack {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    Text(viewStore.state.sceneStates.count, format: .number)
                    IfLetStore(store.scope(state: \.sceneStates[id: sceneID ?? UUID()], action: AppReducer.Action.sceneAction)) { store in
                        VStack {
                            Text(sceneID?.uuidString ?? "")
                            TabContainer(store: store)
                        }
                    } else: {
                        Color.clear
                    }
                }
                .onAppear {
                    sceneID = UUID()
                    if let sceneID {
                        viewStore.send(.createNewScene(sceneID))
                    }
                }
                .onDisappear {
                    if let sceneID {
                        viewStore.send(.deleteScene(sceneID))
                    }
                }
            }
        }
    }
}
