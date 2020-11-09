//
//  AdidasAlert.swift
//  adidas-task
//
//  Created by Jaime Domenech on 09/11/2020.
//
//  Definition of Popups of the app Adidas-task
//
//

import Foundation
import UIKit

enum AdidasAlert {
    
    case noData
    case healthKitAdvisory
}



extension AdidasAlert {
    
    func show(in vc: UIViewController, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: self.getTitle(),
                                      message: self.getMessage(),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: self.getAcceptButtonText(),
                                      style: .default, handler: handler))
        

        vc.present(alert, animated: true, completion: nil)
    }
}

private extension AdidasAlert {
    
    func getTitle() -> String {
        switch self {
        case .noData:
            return NSLocalizedString("errorNoDataTitle", comment: "")
        case .healthKitAdvisory:
            return NSLocalizedString("healthKitAdvisoryTitle", comment: "")
        }
    }
    
    func getMessage() -> String {
        switch self {
        case .noData:
            return NSLocalizedString("errorNoDataDescription", comment: "")
        case .healthKitAdvisory:
            return NSLocalizedString("healthKitAdvisoryDescription", comment: "")
        }
    }
    
    func getAcceptButtonText() -> String {
        switch self {
        case .noData, .healthKitAdvisory:
            return NSLocalizedString("adidasAlertOKButtonTitle", comment: "")
        }
    }
}
