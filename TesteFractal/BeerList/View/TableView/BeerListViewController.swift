//
//  BeerListViewController.swift
//  TesteFractal
//
//  Created by Henrique Valcanaia on 04/09/17.
//  Copyright © 2017 Henrique Valcanaia. All rights reserved.
//

import DZNEmptyDataSet
import Foundation
import UIKit

protocol BeerListViewControllerDelegate: class {
    func beerListViewController(_ controller: BeerListViewController, didSelect beer: BeerViewModel)
}

class BeerListViewController: UIViewController, BeerListInterfaceProtocol, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let presenter = BeerListPresenter()
    private let refreshControl = UIRefreshControl()
    private weak var delegate: BeerListViewControllerDelegate?
    
    private var beers: [BeerViewModel]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBOutlet weak var beerSelectionSegmentedControl: UISegmentedControl!
    
    
    // - ViewController lifecycle
    init(delegate: BeerListViewControllerDelegate? = nil) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        title = NSLocalizedString("Beers", comment: "")
        
        prepareTableView()
        preparePresenter()
        automaticallyAdjustsScrollViewInsets = true
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = []
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.title = NSLocalizedString("Beers", comment: "")
        beerSelectionSegmentedControl.addTarget(self, action: #selector(didTapSegmentedControl(segmentedControl:)), for: .valueChanged)
        
        pullToRefreshProgramatically()
    }
    
    // MARK: - Private methods
    private func prepareTableView() {
        tableView.register(cellType: BeerTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Appearance.Theme.lightGray
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        let title = NSLocalizedString("Pull to refresh", comment: "")
        let attributedTitle = NSAttributedString(string: title, attributes: [NSForegroundColorAttributeName:Appearance.Theme.lightGray])
        refreshControl.attributedTitle = attributedTitle
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Pull to refresh", comment: ""))
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = Appearance.tintColor
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
    }
    
    private func preparePresenter() {
        presenter.interface = self
    }
    
    @objc private func pullToRefresh() {
        loadData()
    }
    
    private func loadData() {
        debugPrint("Selected: \(beerSelectionSegmentedControl.selectedSegmentIndex)")
        guard let selection = BeerSelection(rawValue: beerSelectionSegmentedControl.selectedSegmentIndex) else {
            debugPrint("Unexpected selected value: \(beerSelectionSegmentedControl.selectedSegmentIndex)")
            return
        }
        
        switch selection {
        case .all:
            presenter.loadData()
        case .favorites:
            presenter.loadFavorites()
        }
    }
    
    private func pullToRefreshProgramatically() {
        refreshControl.refreshManually()
    }
    
    @objc private func didTapSegmentedControl(segmentedControl: UISegmentedControl) {
        loadData()
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let beer = beers?[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as BeerTableViewCell
        cell.viewModel = beer
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = beers?[indexPath.row] else {
            debugPrint("Invalid index \(indexPath.row)")
            return
        }
        
        delegate?.beerListViewController(self, didSelect: viewModel)
        
    }
    
    // MARK: - BeerListInterfaceProtocol
    func didOccur(error: Error) {
        debugPrint(error)
        refreshControl.endRefreshing()
    }
    
    func didLoad(beers: [BeerViewModel]) {
        self.beers = beers
    }
    
    func showEmptyState() {
        debugPrint("empty")
        refreshControl.endRefreshing()
    }
    
    // MARK: - DZNEmptyDataSetSource
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return Image.sad.instance
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = NSLocalizedString("Nothing to see here", comment: "")
        
        let attributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18),
            NSForegroundColorAttributeName: UIColor.darkGray
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = NSLocalizedString("Please, make sure you're connected to the internet", comment: "")
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14),
            NSForegroundColorAttributeName: UIColor.lightGray,
            NSParagraphStyleAttributeName: paragraph
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let text = NSLocalizedString("Refresh", comment: "")
        let attributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 17),
            NSForegroundColorAttributeName: Appearance.tintColor
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    // MARK: - DZNEmptyDataSetDelegate
    func imageAnimation(forEmptyDataSet scrollView: UIScrollView!) -> CAAnimation! {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.repeatCount = 2
        animation.duration = TimeInterval(0.2/animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = -5
        
        return animation
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        refreshControl.refreshManually()
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
