//
//  UINavigationControllerExtension.swift
//  iTuneArtist
//
//  Created by Sai Leung on 2/22/21.
//

import Foundation
import UIKit

extension UINavigationController {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UINavigationController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
