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
    private var searchButtonPressedSubject = PassthroughSubject<Void, Never>()
    private var anyCancellable: AnyCancellable?
    
    private var artistName = ""
    
    private var webservice = Webservice()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupSearchTextFieldLayout()
        observeSearchTextField()
        observeSearchButtonPressed()
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        searchButtonPressedSubject.send()
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
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
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

// MARK: - SearchButton
extension ViewController {
    
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
                    }, receiveValue: { (artists) in
                        Spinner.removeSpinner(self)
                        if artists.isEmpty {
                            self.presentAlert(type: .noArtistFound)
                        }
                        print("Result: \(artists)")
                    })
                    
                
                print("Search button pressed: artistName: \(urlHostAllowedArtistName)")
            }
            .store(in: &subscribers)
    }
    
}

// MARK: Alert Message Handling
extension ViewController {
    
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




