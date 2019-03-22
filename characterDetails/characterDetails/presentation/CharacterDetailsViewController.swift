//
//  CharacterDetailsViewController.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import base
import RxSwift
import RxCocoa
import Cartography

protocol BaseTableViewCell {
    
}

protocol CharacterDetailsPresenterProtocol {
    
    var viewModels: Driver<[BaseTableViewCell]> { get }
    
    var viewTitle: Driver<String> { get }
    
    func viewDidLoad()
    func didTap(viewModel: BaseTableViewCell)
}

final class CharacterDetailsViewController: BaseViewController {
    
    private var presenter: CharacterDetailsPresenterProtocol {
        return basePresenter as! CharacterDetailsPresenterProtocol
    }
    
    private let tableView = UITableView(frame: .zero)
    
    private var viewModels: [BaseTableViewCell] = []
    
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
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CharacterDetailsHeaderTableViewCell.nibName, bundle: Bundle(identifier: "com.renan.dias.characterDetails")), forCellReuseIdentifier: CharacterDetailsHeaderTableViewCell.nibName)
        tableView.register(UINib(nibName: SimpleLabelTableViewCell.nibName, bundle: Bundle(identifier: "com.renan.dias.characterDetails")), forCellReuseIdentifier: SimpleLabelTableViewCell.nibName)
        
//        title = "Character"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        
        presenter.viewTitle
            .drive(rx.title)
            .disposed(by: disposeBag)
    }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if let viewModel = viewModels[row] as? CharacterDetailsHeaderTableViewCellProtocol, let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsHeaderTableViewCell.nibName, for: indexPath) as? CharacterDetailsHeaderTableViewCell {
            cell.bind(viewModel: viewModel)
            return cell
            
        } else if let viewModel = viewModels[row] as? SimpleLabelTableViewCellProtocol, let cell = tableView.dequeueReusableCell(withIdentifier: SimpleLabelTableViewCell.nibName, for: indexPath) as? SimpleLabelTableViewCell {
            cell.bind(viewModel: viewModel)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTap(viewModel: viewModels[indexPath.row])
    }
}
