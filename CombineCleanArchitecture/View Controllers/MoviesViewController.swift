//
//  ViewController.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 longtranz. All rights reserved.
//

import UIKit

protocol MovieListViewProtocol {
    func updateList()
}

class MoviesViewController: UIViewController,
                            UITableViewDataSource,
                            UITableViewDelegate,
                            MovieListViewProtocol,
                            NowPlayingTableViewCellDelegate {
    @IBOutlet private weak var moviesTableView: UITableView!
    
    private var presenter: MovieListPresenterProtocol!
    private var movieRepository: MovieRepositoryProtocol!
    private var movieListInteractor: MovieListInteractorProtocol!
    private var movieListRouter: MovieListRouterProtocol!
    private var refreshMovieControl = UIRefreshControl()
    
    private let HEADER_HEIGHT: CGFloat = 23.0
    
    private let sectionHeaders = ["Playing Now", "Most popular"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupData()
                
        movieListInteractor?.fetchMovies(page: movieListInteractor?.currentPage ?? 1)
    }
    
    func setupData() {
        movieListRouter = MovieListRouter(viewController: self)
        presenter = MovieListPresenter(view: self)
        movieRepository = MovieRepository()
        movieListInteractor = MovieListInteractor(presenter: presenter,                                           
                                                  movieWebRepository: movieRepository)
        movieListInteractor.fetchMovies(page: movieListInteractor.currentPage)
        
    }
    
    func setupView() {
        setupNavigationBar()
        
        refreshMovieControl.addTarget(self, action: #selector(refreshMovies), for: .valueChanged)
        
        moviesTableView.refreshControl = refreshMovieControl
        moviesTableView.backgroundColor = AppConstants.Color.mainBackground
        moviesTableView.contentInset = UIEdgeInsets(top: 0,
                                                    left: 0,
                                                    bottom: view.safeAreaInsets.bottom,
                                                    right: 0)
    }
    
    func setupNavigationBar() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = AppConstants.Color.navBackground

        navigationController?.navigationBar.standardAppearance = navAppearance
        
        let titleImage = UIImage(named: "MovieBox")?.withRenderingMode(.alwaysTemplate)
        let titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 155, height: 19))
        titleImageView.image = titleImage
        titleImageView.tintColor = AppConstants.Color.movieListHeaderText
        titleImageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = titleImageView
    }
    
    func updateList() {
        refreshMovieControl.endRefreshing()
        
        moviesTableView.reloadData()
    }
    
    @objc
    private func refreshMovies() {
        refreshMovieControl.beginRefreshing()
        
        movieListInteractor?.refreshMovies()
    }
    
    // MARK: - Now playing table view cell delegate
    func didSelectNowPlayingMovie(with id: Int) {
        movieListRouter.showMovie(id: id)
    }
    
    // MARK: - Table view
    private func prepareNowPlayingCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowPlayingCell",
                                                           for: indexPath) as! NowPlayingTableViewCell
        cell.delegate = self
        return cell
    }
    
    private func prepareMovieCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell",
                                                           for: indexPath) as! MovieCell
        if let movieEntity = movieListInteractor?.getMovieAt(indexPath.row) {
            cell.configure(movie: movieEntity)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : presenter.viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return prepareNowPlayingCell(tableView, cellForRowAt: indexPath)
        default:
            return prepareMovieCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movieItem = presenter.viewModel.movies[indexPath.row]
        
        guard let movieItemId = movieItem.id else { return }
        
        movieListRouter.showMovie(id: movieItemId)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.viewModel.movies.count - 1,
           let interactor = movieListInteractor {
            interactor.fetchMovies(page: interactor.currentPage)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 176 : 150
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: moviesTableView.frame.width,
                                              height: HEADER_HEIGHT))
        headerView.backgroundColor = AppConstants.Color.movieListHeaderBackground
        
        let headerLabel = UILabel()
        headerLabel.text = sectionHeaders[section]
        headerLabel.textColor = AppConstants.Color.movieListHeaderText
        headerLabel.font = UIFont.systemFont(ofSize: 12)
        headerLabel.sizeToFit()
        headerLabel.frame = CGRect(origin: CGPoint(x: 21,
                                                   y: (headerView.frame.height - headerLabel.frame.height) / 2),
                                   size: headerLabel.frame.size)
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HEADER_HEIGHT
    }
}
