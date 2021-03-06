//
//  ViewController.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/20/21.
//

import UIKit
import Combine
import SwiftUI

class ViewController: UIViewController, ObservableObject {
    
    private let notificationCenter = NotificationCenter.default
    private var subscribers = Set<AnyCancellable>()
    private var searchButtonPressedSubject = PassthroughSubject<Void, Never>()
    private var anyCancellable: AnyCancellable?
    
    private var artistName = ""
    
    @Published var artistViewModels = [ArtistViewModel]()
    
    private var webservice = Webservice()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var artistResultsContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupSearchTextFieldLayout()
        observeSearchTextField()
        observeSearchButtonPressed()
        addArtistListView(artists: artistViewModels)
        navigationController?.setupToHideKeyboardOnTapOnView()
        searchTextField.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        // Publish when user press the search button
        searchButtonPressedSubject.send()
    }
    
}

// MARK: - NavigationItem Setup
extension ViewController {
    
    // Customize NavigationItem font and position
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
extension ViewController: UITextFieldDelegate {
    
    private func setupSearchTextFieldLayout() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "magnifyingglass")
        searchTextField.leftViewMode = .unlessEditing
        searchTextField.leftView = imageView
        searchTextField.clearButtonMode = .whileEditing
    }
    
    // Subscriber to handle user's input in searchTextField
    private func observeSearchTextField() {
        notificationCenter.publisher(for: UITextField.textDidChangeNotification, object: searchTextField)
            .sink { [weak self] in
                guard let textField = $0.object as? UITextField,
                      let artistName = textField.text else {
                    return
                }
                self?.artistName = artistName
            }
            .store(in: &subscribers)
            
    }
    
    // When return button is pressed on keyboard, search will occur based on textField input
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchButtonPressedSubject.send()
        return false
    }
}

// MARK: - SearchButton
extension ViewController {
    
    // Subscriber to handle Webservice fetching artist data when user pressed the search button
    private func observeSearchButtonPressed() {
        searchButtonPressedSubject
            .sink { [weak self] (_) in
                guard let self = self else { return }
                guard let urlHostAllowedArtistName = self.artistName.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                      !urlHostAllowedArtistName.isEmpty
                else {
                    self.presentAlert(type: .emptyString)
                   return
                }
                Spinner.showSpinner(self)
                self.anyCancellable = self.webservice.fetchArtist(name: urlHostAllowedArtistName)
                    .sink(receiveCompletion: { (completion) in
                        Spinner.removeSpinner(self)
                        switch completion {
                        case .failure( _):
                            self.presentAlert(type: .artistFetchSessionError)
                        default:
                            break
                        }
                    }, receiveValue: { (artistViewModels) in
                        Spinner.removeSpinner(self)
                        if artistViewModels.isEmpty {
                            self.presentAlert(type: .noArtistFound)
                        }
                        self.artistViewModels = artistViewModels
                    })
            }
            .store(in: &subscribers)
    }
    
}

// MARK: Alert Message Handling
extension ViewController {
    
    // Present alert based on specifi scenerios
    private func presentAlert(type: AlertError) {
        var alertTitle = ""
        var alertMessage = ""
        switch type {
        case .emptyString:
            alertTitle = "Did you forget the artist?"
            alertMessage = "Please enter artist name to search."
        case .artistFetchSessionError:
            alertTitle = "Error searching this artist"
            alertMessage = "Please try again."
        case .noArtistFound:
            alertTitle = "No artist found"
            alertMessage = "Please try another artist."
        }
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: ArtistListView
extension ViewController {
    
    // This function allows ArtistListView as SwiftUI view to integrate and be contained inside of regular UIView
    private func addArtistListView(artists: [ArtistViewModel]) {
        let artistListView = ArtistListView(viewController: self)
        let hostingController = UIHostingController(rootView: artistListView)
        
        artistResultsContainerView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup the SwiftUI view constraints to the UIView boundaries
        let constraints = [
               hostingController.view.topAnchor.constraint(equalTo: artistResultsContainerView.topAnchor),
               hostingController.view.leftAnchor.constraint(equalTo: artistResultsContainerView.leftAnchor),
               artistResultsContainerView.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
               artistResultsContainerView.rightAnchor.constraint(equalTo: hostingController.view.rightAnchor)
           ]

        NSLayoutConstraint.activate(constraints)
    }
    
}




