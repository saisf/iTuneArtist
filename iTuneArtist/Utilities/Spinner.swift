//
//  Spinner.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/21/21.
//

import UIKit

// Spinner when fetching data
class Spinner: UIViewController {

    var spinner = UIActivityIndicatorView(style: .large)
    
    static let shared = Spinner()

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    static func showSpinner(_ viewController: UIViewController) {
        viewController.addChild(shared)
        shared.view.frame = viewController.view.frame
        viewController.view.addSubview(shared.view)
    }
    
    static func removeSpinner(_ viewController: UIViewController) {
        shared.willMove(toParent: nil)
        shared.view.removeFromSuperview()
        shared.removeFromParent()
    }
    
}
