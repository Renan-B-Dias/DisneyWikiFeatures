//
//  MovieDetailsViewController.swift
//  movieDetails
//
//  Created by Renan Benatti Dias on 22/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UI
import Cartography
import base
import data

protocol MovieDetailsProtocol {
    
    var movieViewModels: [BaseTableViewCell] { get }
    
    var reloadTableView: Driver<Void> { get }
    var movieTitle: Driver<String> { get }
    
    func didTapAt(index: Int)
}

public final class MovieDetailsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero)
    
    private let disposeBag = DisposeBag()
    private let viewModel: MovieDetailsProtocol
    
    public init(movieId: Int, router: MovieDetailsRouterProtocol) {
        self.viewModel = MovieDetailsViewModel(movieId: movieId, repository: MoviesRepository(), router: router)
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    public override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CharacterDetailsHeaderTableViewCell.nibName, bundle: Bundle(identifier: "com.renan.dias.UI")), forCellReuseIdentifier: CharacterDetailsHeaderTableViewCell.nibName)
        tableView.register(UINib(nibName: SimpleLabelTableViewCell.nibName, bundle: Bundle(identifier: "com.renan.dias.UI")), forCellReuseIdentifier: SimpleLabelTableViewCell.nibName)
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func bind() {
        
        viewModel.reloadTableView
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.movieTitle
            .drive(rx.title)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        if let viewModel = viewModel.movieViewModels[row] as? CharacterDetailsHeaderTableViewCellProtocol, let cell = tableView.dequeueReusableCell(withIdentifier: CharacterDetailsHeaderTableViewCell.nibName, for: indexPath) as? CharacterDetailsHeaderTableViewCell {
            cell.bind(viewModel: viewModel)
            return cell

        } else if let viewModel = viewModel.movieViewModels[row] as? SimpleLabelTableViewCellProtocol, let cell = tableView.dequeueReusableCell(withIdentifier: SimpleLabelTableViewCell.nibName, for: indexPath) as? SimpleLabelTableViewCell {
            cell.bind(viewModel: viewModel)
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didTapAt(index: indexPath.row)
    }
}
