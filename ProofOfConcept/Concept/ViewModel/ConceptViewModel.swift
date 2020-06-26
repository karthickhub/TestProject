//
//  ConceptVM.swift
//  ProofOfConcept
//
//  Created by Apple on 25/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

enum ConceptViewModelItemType{
    case conceptData
}

protocol ConceptViewModelItem {
    var type: ConceptViewModelItemType { get }
    var sectionTitle : String { get }
    var rowCount : Int { get }
}

protocol GetConceptDelegate {
    
    func getConceptData(navTitle:String, title:NSArray, description:NSArray, imageHref:NSArray)
}

class ConceptViewModel: NSObject {
    
    var items = [ConceptViewModelItem]()
    var conceptDelegate: GetConceptDelegate? = nil
    override init() {
        super.init()
          //DataDisplay
         ConceptRequest()
    }
    
    //MARK: - Api integration - To display the name, description and image 
     func ConceptRequest(){
         AF.request(BaseURL.concept).response { response in
                //responseData - coversion
                let responseData = String(data: response.data!, encoding: .isoLatin1)
                //Data to UTF8 String
                let getResponseData = responseData?.data(using: .utf8)
                guard let data = getResponseData else { return }
                     do {
                         let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
                         let navTitle = json?["title"] as? String
                         let rows = json?["rows"] as? NSArray
                         let title = rows?.value(forKey: "title") as? NSArray
                         let description = rows?.value(forKey: "description") as? NSArray
                         let imageRef = rows?.value(forKey: "imageHref") as? NSArray
                        self.conceptDelegate?.getConceptData(navTitle:navTitle ?? STRING.Text.KEmpty,title:title ?? [], description:description ?? [], imageHref:imageRef ?? [])
                        

                     } catch {
                             print(error)
                     }
             }
    }
    
}



