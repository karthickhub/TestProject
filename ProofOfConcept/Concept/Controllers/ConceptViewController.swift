//
//  ConceptVC.swift
//  ProofOfConcept
//
//  Created by Apple on 25/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ConceptViewController: UIViewController {
    
    //MARK:- Outlets
    //tableView
    @IBOutlet weak var conceptTableView: UITableView!
    //titleLbl
    @IBOutlet weak var conceptNavBarTitle: UILabel!
    //viewmodel
    fileprivate let viewModel = ConceptViewModel()
    //Variables
    var navconceptTitle: String?
    var conceptNameData: [String]?
    var conceptDescData: [String]?
    var conceptImageData: [String]?
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        //ConfigureView
        configureView()
        //registerXib
        registerNibClasses()
        
    }
    
    //MARK:- ConfigureView
    func configureView(){
        viewModel.conceptDelegate = self
        //RefreshControl
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
         conceptTableView.addSubview(refreshControl)
    }
    //Refresh Data
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        conceptTableView.reloadData()
        refreshControl.endRefreshing()
    }
    //MARK:- RegisterNibClasses
    private func registerNibClasses() {
        ConceptTableCell.registerXIB(with: conceptTableView)
    }
}

//MARK: - ConceptViewController - TableView Delegate
extension ConceptViewController: UITableViewDelegate{
    
}

//MARK: - ConceptViewController - TableView Datasource
extension ConceptViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conceptImageData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell: ConceptTableCell = tableView.dequeueReusableCell(withIdentifier:"ConceptTableCell", for: indexPath) as! ConceptTableCell
        cell.selectionStyle = .none
            self.conceptNavBarTitle.text = self.navconceptTitle
            cell.conceptName.text = self.conceptNameData?[indexPath.row]
            cell.conceptDescription.text = self.conceptDescData?[indexPath.row]
            cell.conceptImage.downloaded(from: self.conceptImageData?[indexPath.row] ?? STRING.Text.KEmpty)
          return cell
    }
}

//MARK: - GetConceptDelegate
extension ConceptViewController: GetConceptDelegate{
    func getConceptData(navTitle: String,title: NSArray, description: NSArray, imageHref: NSArray) {
        navconceptTitle = navTitle
        conceptNameData = title.compactMap({ $0 as? String })
        conceptDescData  = description.compactMap({ $0 as? String })
        conceptImageData = imageHref.compactMap({ $0 as? String })
        self.conceptTableView.reloadData()
    }
    
    
}




