//
//  PINDialog.swift
//  PIN Dialog Sample
//
//  Created by Mano on 14/11/18.
//

import UIKit

class PINDialog: NSObject {
    
    var rootWindow: UIWindow!
    
    // Singleton.
    class var sharedInstance: PINDialog {
        struct Static {
            static let instance: PINDialog = PINDialog()
        }
        return Static.instance
    }
    
    public override init() {}
    
    // show alert.
    func showAlertView(
        title: String? = nil,
        message: String,
        actionTitles: [String],
        actions: [(UIAlertController) -> ()]?) {
        // create new window.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.clear
        window.rootViewController = UIViewController()
        PINDialog.sharedInstance.rootWindow = UIApplication.shared.windows[0]
        //create alertview.
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = ""
            textField.font = UIFont(name: "Courier", size: 48)
            textField.isSecureTextEntry = true
            textField.textAlignment = .center
            textField.keyboardType = UIKeyboardType.numberPad
        })
        for title in actionTitles {
            //add action.
            let action = UIAlertAction(title: title, style: .default, handler: {[weak alert] (action : UIAlertAction) -> Void in
                if let acts = actions {
                    if acts.count >= actionTitles.count {
                        acts[actionTitles.index(of: title)!](alert!)
                    }
                }
                DispatchQueue.main.async(execute: { () -> Void in
                    alert?.dismiss(animated: true, completion: nil)
                    window.isHidden = true
                    window.removeFromSuperview()
                    PINDialog.sharedInstance.rootWindow.makeKeyAndVisible()
                })
            })
            alert.addAction(action)
        }
        
        window.windowLevel = UIWindowLevelAlert
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
