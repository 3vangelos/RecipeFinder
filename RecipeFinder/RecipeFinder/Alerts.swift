//
//  Alerts.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos on 13.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class Alerts {
    static func showNetworkError(target: UIViewController, title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(alertAction)
        target.present(alertController, animated: true)
    }
}
