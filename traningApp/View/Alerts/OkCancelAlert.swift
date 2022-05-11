//
//  OkCancelAlert.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 11.05.2022.
//


import UIKit

extension UIViewController {
    
    func alertOkCancel(title:String, message:String?, completioHandler: @escaping () -> Void) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { _ in
            completioHandler()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
