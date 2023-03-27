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
    var alert: UIAlertController?
    
    private var contacts: [String] = []
    
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
        alert = UIAlertController(title: "Add Contact", message: "Enter contact name", preferredStyle: .alert)
        alert?.addTextField() { textField in
            textField.placeholder = "First name"
            textField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
        }
        alert?.addTextField() { textField in
            textField.placeholder = "Last name"
            textField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
        }
        let save = UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
            guard let text = self.alert?.textFields?.first?.text, !text.isEmpty else { return }
            self.contacts.append(text)
            self.tableView.reloadData()
        }
        save.isEnabled = false
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert?.addAction(save)
        alert?.addAction(cancel)
        guard let alert = alert else { return }
        present(alert, animated: true)
    }
    
    @objc func checkTextField() {
        guard let firstText = alert?.textFields?.first?.text, let secondText = alert?.textFields?.last?.text else { return }
        guard let action = alert?.actions.first else { return }
        if !firstText.isEmpty && !secondText.isEmpty {
            action.isEnabled = true
        } else {
            action.isEnabled = false
        }
    }
    
}

// MARK: TableView DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: "person.circle")
        content.text = contacts[indexPath.row]
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

