//
//  MovieListViewController.swift
//  moviesList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cartography
import base
import data

protocol MovieListViewModelProtocol {
    
    var movies: Driver<[MovieTableViewCellProtocol]> { get }
    
    func didTapMovieWith(id: Int)
}

public final class MovieListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel: MovieListViewModelProtocol
    
    // Might move this to viewModel
    private var movieViewModels: [MovieTableViewCellProtocol] = []
    
    private let tableView = UITableView(frame: .zero)
    
    public init(router: MovieListRouterProtocol) {
        self.viewModel = MovieListViewModel(repository: MoviesRepository(), router: router)
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    override public func loadView() {
        super.loadView()
        
        view.addSubview(tableView)
        constrain(view, tableView) { (view, tableView) in
            tableView.edges == view.edges
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    private func bind() {
        viewModel.movies
            .drive(onNext: { [weak self] (movies) in
                guard let self = self else { return }
                self.movieViewModels = movies
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: MovieTableViewCell.nibName, bundle: Bundle(identifier: "com.renan.dias.moviesList")), forCellReuseIdentifier: MovieTableViewCell.nibName)
        
        title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModels.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.nibName, for: indexPath) as? MovieTableViewCell {
            cell.bind(viewModel: movieViewModels[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movieViewModel = movieViewModels[indexPath.row]
        viewModel.didTapMovieWith(id: movieViewModel.id)
    }
}
