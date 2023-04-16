//
//  AppReducer.swift
//  SingleStore
//
//  Created by Yang Xu on 2023/4/14.
//

import ComposableArchitecture
import Foundation

struct AppReducer: ReducerProtocol {
    struct State: Equatable {
        var sceneStates: IdentifiedArrayOf<SceneReducer.State> = .init()
        var hitCount = 0
    }

    enum Action: Equatable {
        case createNewScene(UUID)
        case deleteScene(UUID)
        case forEachAction(id: UUID, action: SceneReducer.Action)
    }

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .createNewScene(id):
                if state.sceneStates[id: id] == nil {
                    state.sceneStates.append(.init(id: id))
                }
            case let .deleteScene(id):
                state.sceneStates.remove(id: id)
            case .forEachAction(id: _, action: .hitButtonTapped):
                state.hitCount += 1
            default:
                break
            }
            return .none
        }
        .forEach(\.sceneStates, action: /Action.forEachAction) {
            SceneReducer()
        }
    }
}
