//
//  MotionListViewController.swift
//  GyroData
//
//  Created by 이호영 on 2022/12/27.
//

import UIKit

class MotionListViewController: UIViewController {

    private lazy var motionListTableView: UITableView = {
       let tableView = UITableView()
       tableView.delegate = self
       tableView.dataSource = self
       tableView.register(
           MotionListTableViewCell.self,
           forCellReuseIdentifier: MotionListTableViewCell.cellIdentifier
       )
       tableView.translatesAutoresizingMaskIntoConstraints = false
       return tableView
   }()
    
    private var viewModel: MotionListViewModel = MotionListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        configureNavigationBar()
    }

    private func setupView() {
        addSubViews()
        setupConstraints()
        view.backgroundColor = .systemBackground
    }
    
    func addSubViews() {
        view.addSubview(motionListTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            motionListTableView.topAnchor.constraint(equalTo: view.topAnchor),
            motionListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            motionListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            motionListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bind(to viewModel: MotionListViewModel) {
        viewModel.items.subscribe() { [weak self] _ in self?.updateItem() }
        viewModel.loadItems(count: 10)
    }
}

extension MotionListViewController: UITableViewDelegate {
     
}

extension MotionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MotionListTableViewCell.cellIdentifier, for: indexPath) as? MotionListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(motion: self.viewModel.items.value[indexPath.row])
        return cell
    }
    
    func updateItem() {
        motionListTableView.reloadData()
    }
}

// MARK: NavigationController

extension MotionListViewController {
    private func configureNavigationBar() {
        let measurementBarButton = UIBarButtonItem(title: "측정",
                                            style: .done,
                                            target: self,
                                            action: #selector(measurementBarButtonTapped))

        navigationItem.rightBarButtonItem = measurementBarButton
        navigationItem.title = "목록"
    }

    @objc private func measurementBarButtonTapped() {
        let measurementViewController = MeasurementViewController()
        navigationController?.pushViewController(measurementViewController, animated: true)
    }
    
    private func pushMotionResultScene(motion: Motion) {
        // 모션결과 페이지에 motionData 전달 및 push
    }
}

// MARK: TableView SwipeAction

extension MotionListViewController {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let playAction = UIContextualAction(style: .normal, title: "Play") { _, _, completionHandler in
            self.pushMotionResultScene(motion: self.viewModel.items.value[indexPath.row])
            completionHandler(true)
        }
        playAction.backgroundColor = .systemGreen
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, completionHandler in
            self.viewModel.deleteItem(motion: self.viewModel.items.value[indexPath.row])
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [deleteAction, playAction])
    }
}
