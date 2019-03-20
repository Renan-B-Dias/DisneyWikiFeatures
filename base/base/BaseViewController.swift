//
//  BaseViewController.swift
//  base
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import RxSwift

public protocol BasePresenterProtocol {
    
}

open class BaseViewController: UIViewController {
    
    public let basePresenter: BasePresenterProtocol
    
    public let disposeBag = DisposeBag()
    
    public init(presenter: BasePresenterProtocol) {
        self.basePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    open func bind() {
        
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
