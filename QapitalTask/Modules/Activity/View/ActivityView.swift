//
//  ActivityView.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation
import UIKit
import UIScrollView_InfiniteScroll

class ActivityView: BaseViewController {
    
    // MARK:- Constants
    struct Constants {
        static let cellIdentifier = "ActivityViewCell"
    }
    
    // MARK:- Properties
    var presenter: ActivityPresenterProtocol?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ActivityView.loadActivites), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
   
    // MARK:- UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewLoaded()
        registerCell()
        setupTableView()
    }
    
    override func hideLoader() {
        super.hideLoader()
        refreshControl.endRefreshing()
        tableView.finishInfiniteScroll()
    }
    
    // MARK:- Private Methods
    fileprivate func registerCell(){
        let activityCell = UINib(nibName: Constants.cellIdentifier, bundle:nil)
        tableView.register(activityCell, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    fileprivate func setupTableView() {

        tableView.addSubview(refreshControl)
    }
    @objc fileprivate func loadActivites() {
        presenter?.viewLoaded()
    }
}

// MARK:- ActivityViewProtocol
extension ActivityView: ActivityViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }
    
    func addNextPageLoader(completion: (() -> ())?) {
        tableView.addInfiniteScroll { (_) in
            completion?()
        }
    }
    
    func removeNextPageLoader() {
        tableView.removeInfiniteScroll()
    }
}

// MARK:- Table view Delegate
extension ActivityView : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! ActivityViewCell
        cell.configure(viewModel: presenter!.getItem(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.cellWillLoad(at: indexPath.row)
    }
}
