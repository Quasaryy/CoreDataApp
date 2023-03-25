//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Yury on 25/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    private let cellID = "Cell"
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
                
        addSubViews()
        addConstaraints()
        setupNavigationBar()
    }

}

// MARK: Private Methods
extension ViewController {
    private func addConstaraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
    }
    
    private func setupNavigationBar() {
        title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        
        let appereance = UINavigationBarAppearance()
        appereance.backgroundColor = .systemCyan
        appereance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appereance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appereance
        navigationController?.navigationBar.scrollEdgeAppearance = appereance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
    }
    
    @objc private func addContact() {
        
    }
    
}

// MARK: TableView DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "person.circle")
        content.text = "Full Name"
        content.imageProperties.tintColor = .systemCyan
        cell.contentConfiguration = content

        return cell
    }
    
}

// MARK: TableView Delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

