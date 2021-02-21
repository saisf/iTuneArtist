//
//  ViewController.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationItem()
        setupSearchTextFieldLayout()
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
}



