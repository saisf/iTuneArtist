//
//  ViewController.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationItem()
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



