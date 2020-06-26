//
//  ConceptTableCell.swift
//  ProofOfConcept
//
//  Created by Apple on 25/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ConceptTableCell: UITableViewCell {
    
    @IBOutlet weak var conceptName: UILabel!
    @IBOutlet weak var conceptImage: UIImageView!
    @IBOutlet weak var conceptDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib:UINib {
         return UINib(nibName: identifier, bundle: nil)
     }
     
     static func registerXIB(with table: UITableView){
         let nib = UINib.init(nibName: "ConceptTableCell", bundle: nil)
         table.register(nib, forCellReuseIdentifier: "ConceptTableCell")
     }
     
     static var identifier: String {
         return String(describing: self)
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - ImageView Extension
extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
