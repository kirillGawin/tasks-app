//
//  TaskDetailsViewController.swift
//  TasksApp
//
//  Created by gawin on 30/12/2025.
//

import UIKit

final class TaskDetailsViewController: UIViewController {
    
    var onSave: (() -> Void)?
    
    private let textField = UITextField()
    
    private let service = TasksService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
       title = "New Task"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(saveTapped))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped))
        
        textField.placeholder = "Task Title"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        
    
        view.addSubview(textField)
      
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    
    @objc private func saveTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        service.createTask(title: text)
        onSave?()
        dismiss(animated: true)
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
}
