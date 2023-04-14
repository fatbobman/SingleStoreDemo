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
                    Text(viewStore.state.sceneStates.count, format: .number)
                    IfLetStore(store.scope(state: \.sceneStates[id: sceneID], action: AppReducer.Action.sceneAction)) { store in
                        VStack {
                            Text(sceneID.uuidString)
                            TabContainer(store: store)
                        }
                    }
                }
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
