//
//  TasksViewController.swift
//  TasksApp
//
//  Created by gawin on 30/12/2025.
//

import UIKit

final class TasksViewController: UIViewController {
    
    private let service = TasksService()
    private var tasks: [Task] = []
    
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        reloadData()
    }
    
    private func reloadData() {
        tasks = service.fetchAll()
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Tasks"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addTapped))
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addTapped() {
        let detailsVC = TaskDetailsViewController()
        
        detailsVC.onSave = { [weak self] in
            self?.reloadData()
        }
        
        let nav = UINavigationController(rootViewController: detailsVC)
        present(nav, animated: true)
    }
}

extension TasksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.isCompleted ? .checkmark : .none
        return cell
        }
    }
    
extension TasksViewController: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _ = tasks[indexPath.row]
       
        reloadData()
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        service.delete(tasks[indexPath.row])
        reloadData()
       }
    }
}
