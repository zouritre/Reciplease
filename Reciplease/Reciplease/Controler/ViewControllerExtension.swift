//
//  ExtensionViewController.swift
//  Le-Baluchon
//
//  Created by Bertrand Dalleau on 10/06/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(message: String) {
        
        let alertView = UIAlertController.init(title: message, message: "", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alertView, animated: true)
    }

}
