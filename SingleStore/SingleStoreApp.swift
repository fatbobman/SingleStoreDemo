//
//  SingleStoreApp.swift
//  SingleStore
//
//  Created by Yang Xu on 2023/4/14.
//

import SwiftUI
import ComposableArchitecture

@main
struct SingleStoreApp: App {
    let store: StoreOf<AppReducer> = .init(initialState: .init(), reducer: AppReducer())
    var body: some Scene {
        WindowGroup {
            ContentView(store: store)
        }
    }
}
