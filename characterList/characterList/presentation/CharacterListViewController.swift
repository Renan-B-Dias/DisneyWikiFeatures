//
//  CharacterListViewController.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import base
import RxSwift
import RxCocoa
import Cartography

protocol  CharacterListPresenterProtocol {
    
    var viewModels: Driver<[CharacterTableViewCellProtocol]> { get }
    
    func viewDidLoad()
    func didSelectCharacter(id: Int)
}

final class CharacterListViewController: BaseViewController {
    
    private var presenter: CharacterListPresenterProtocol {
        return basePresenter as! CharacterListPresenterProtocol
    }
    
    private let tableView = UITableView(frame: .zero)
    
    private var viewModels: [CharacterTableViewCellProtocol] = []
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        presenter.viewDidLoad()
    }
    
    override func bind() {
        super.bind()
        
        presenter.viewModels
            .drive(onNext: { [weak self] (viewModels) in
                guard let self = self else { return }
                self.viewModels = viewModels
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CharacterTableViewCell.nibName, bundle: Bundle(identifier: "com.renan.dias.characterList")), forCellReuseIdentifier: CharacterTableViewCell.nibName)
        
        title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension CharacterListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.nibName, for: indexPath) as? CharacterTableViewCell {
            cell.bind(viewModel: viewModels[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels[indexPath.row]
        presenter.didSelectCharacter(id: viewModel.id)
    }
}
