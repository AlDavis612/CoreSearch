//
//  DocumentViewController.swift
//  DocumentCoreDataSearch
//
//  Created by Alex Davis on 10/4/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var ContentView: UITextView!
    
    var document: Document?
       
    override func viewDidLoad() {
        super.viewDidLoad()
           
        title = ""

        if let document = document {
            let name = document.name
            NameField.text = name
            ContentView.text = document.content
            title = name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
       
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle:UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
           
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func Save(_ sender: Any) {
        guard let name = NameField.text else {
            alertNotifyUser(message: "Save Error")
            return
        }
        
        let documentName = name.trimmingCharacters(in: .whitespaces)
            
        let content = ContentView.text
            
        if document == nil {
            document = Document(name: documentName, content: content)
            } else {
                document?.update(name: documentName, content: content)
            }
            
        if let document = document {
            do {
                let managedContext = document.managedObjectContext
                try managedContext?.save()
            } catch {
                alertNotifyUser(message: "Save Error")
            }
        } else {
            alertNotifyUser(message: "Error")
        }
            
        navigationController?.popViewController(animated: true)
    }
        
}
    
