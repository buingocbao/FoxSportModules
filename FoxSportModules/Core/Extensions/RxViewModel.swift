//
//  RxViewModel.swift
//  Viola-iOS
//
//  Created by Tai Vuong on 3/5/18.
//  Copyright © 2018 2359 Media. All rights reserved.
//

import Foundation
import RxSwift

enum State {
    case idle
    case loading
    case completed
    case error(Error)
}

protocol RxViewModel {
    var disposeBag: DisposeBag { get set }
    var stateVariable: Variable<State> { get set }
    func setState(newState: State)
}

extension RxViewModel {
    func setState(newState: State) {
        stateVariable.value = newState
    }
    
    func handleError<T>(type: T.Type, error: Error) -> Observable<T?> {
        self.setState(newState: .error(error))
        return Observable.empty()
    }
}


