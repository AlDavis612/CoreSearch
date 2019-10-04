//
//  DocumentsViewController.swift
//  DocumentCoreDataSearch
//
//  Created by Alex Davis on 10/4/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//

import UIKit
import CoreData

class DocumentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    @IBOutlet weak var DocumentsView: UITableView!
    let dateFormatter = DateFormatter()
    var documents = [Document]()
    var searchController : UISearchController?
    var searchCondition = SearchFile.everyone

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Documents"

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        searchController = UISearchController(searchResultsController: nil)
        
        searchController?.searchResultsUpdater = self
        searchController?.obscuresBackgroundDuringPresentation = false
        searchController?.searchBar.placeholder = "Search Documents"
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        searchController?.searchBar.scopeButtonTitles = SearchFile.titles
        searchController?.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchDocuments(searchString: "")
    }
    
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            (alertAction) -> Void in
            print("OK selected")
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchDocuments(searchString: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            documents = try managedContext.fetch(fetchRequest)
            DocumentsView.reloadData()
        } catch {
            print("Error")
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text {
            fetchDocuments(searchString: searchString)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedCondition: Int) {
        searchCondition = SearchFile.condition[selectedCondition]
        if let searchString = searchController?.searchBar.text {
            fetchDocuments(searchString: searchString)
        }
    }
    
    func deleteDocument(at indexPath: IndexPath) {
        let document = documents[indexPath.row]
        
        if let managedObjectContext = document.managedObjectContext {
            managedObjectContext.delete(document)
            
            do {
                try managedObjectContext.save()
                self.documents.remove(at: indexPath.row)
                DocumentsView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                DocumentsView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        
        if let cell = cell as? DocTableViewCell {
            let document = documents[indexPath.row]
            cell.NameLabel.text = document.name
            cell.SizeLabel.text = String(document.size) + " bytes"
            
            if let modifiedDate = document.DateModified {
                cell.DateModLabel.text = dateFormatter.string(from: modifiedDate)
            } else {
                cell.DateModLabel.text = "unknown"
            }
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DocumentViewController,
           let segueIdentifier = segue.identifier, segueIdentifier == "preexistingDocument",
           let row = DocumentsView.indexPathForSelectedRow?.row {
                destination.document = documents[row]
        }
    }
}
