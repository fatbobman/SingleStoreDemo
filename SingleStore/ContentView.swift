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
    @State var sceneID: UUID = .init()
    var body: some View {
        VStack {
            WithViewStore(store, observe: { $0 }) { viewStore in
                VStack {
                    sceneStateCount(viewStore.sceneStates.count) // SceneState 的数量
                    appHits(viewStore.state.hitCount)
                    ForEachStore(store.scope(state: \.sceneStates, action: AppReducer.Action.forEachAction)) { store in
                        WithViewStore(store.actionless) { viewStore in
                            if viewStore.id == sceneID {
                                VStack {
                                    sceneID(sceneID) // 当前的 SceneID
                                    TabContainer(store: store)
                                }
                            }
                        }
                    }
                }
                .id(sceneID)
                .onAppear {
                    sceneID = UUID()
                    viewStore.send(.createNewScene(sceneID))
                }
                .onDisappear {
                    viewStore.send(.deleteScene(sceneID))
                }
            }
        }
    }
}

extension ContentView {
    func sceneStateCount(_ count:Int) -> some View {
        HStack {
            Text("Scene State Count:")
            Text(count, format: .number)
        }
    }
    
    func sceneID(_ id:UUID) -> some View {
        HStack {
            Text("SceneID:")
            Text(id.uuidString)
        }
    }
    
    func appHits(_ count:Int) -> some View {
        HStack {
            Text("Hits: \(count)")
        }
    }
}
