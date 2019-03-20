//
//  BasePresenter.swift
//  base
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import Foundation

open class BasePresenter {
    
    public init() {}
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BasePresenter: BasePresenterProtocol {
    
}
