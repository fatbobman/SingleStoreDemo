//
//  SceneReducer.swift
//  SingleStore
//
//  Created by Yang Xu on 2023/4/14.
//

import ComposableArchitecture
import Foundation
import SwiftUI

struct SceneReducer: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let id: UUID
        var tabSelection: Tab = .tab1
    }

    enum Tab: String, Equatable, Identifiable, CaseIterable {
        case tab1, tab2, tab3

        var id: Self {
            self
        }
    }

    enum Action: Equatable {
        case updateTabSelection(Tab)
        case hitButtonTapped
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .updateTabSelection(tab):
                state.tabSelection = tab
            case .hitButtonTapped:
                break
            }
            return .none
        }
    }
}

extension SceneReducer.Tab {
    var color: Color {
        switch self {
        case .tab1:
            return .cyan.opacity(0.6)
        case .tab2:
            return .yellow.opacity(0.6)
        case .tab3:
            return .green.opacity(0.6)
        }
    }
}
