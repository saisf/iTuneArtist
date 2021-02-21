//
//  ViewController.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/20/21.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let notificationCenter = NotificationCenter.default
    private var subscribers = Set<AnyCancellable>()
    
    private var artistName = ""
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationItem()
        setupSearchTextFieldLayout()
        observeSearchTextField()
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
}

// MARK: - NavigationItem Setup
extension ViewController {
    
    private func setupNavigationItem() {
        let label = UILabel()
        label.font = .rounded(ofSize: 50, weight: .black)
        label.textColor = .black
        label.text = "Search"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - SearchTextField Setup
extension ViewController {
    
    private func setupSearchTextFieldLayout() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        searchTextField.leftViewMode = .unlessEditing
        searchTextField.leftView = imageView
        searchTextField.clearButtonMode = .whileEditing
    }
    
    private func observeSearchTextField() {
        notificationCenter.publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
            .sink { [weak self] in
                guard let textField = $0.object as? UITextField,
                      let artistName = textField.text else {
                    return
                }
                self?.artistName = artistName
                print(self?.artistName)
            }
            .store(in: &subscribers)
            
    }
}



