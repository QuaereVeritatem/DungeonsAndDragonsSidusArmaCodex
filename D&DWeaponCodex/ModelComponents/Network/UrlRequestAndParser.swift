//
//  UrlRequestAndParser.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 1/9/18.
//  Copyright © 2018 Robert Martin. All rights reserved.
//

import Foundation

class RequestAndParse {
  
  let dndCount = 37 // real number is 256 //First 37 are weapons
  var JsonDnDPull = DnDResultAPICall.self
  var moreWeapons = [EquipmentModel]()
  var equipMod = [EquipmentModel]()
  var weapMod = [EquipmentModel]()
  var pickerNames = [String]()
  
  // we need to pass in the endpoint (/Posts, /Albums, etc) and return JSON result
  func reqNParse() -> [EquipmentModel] {
    
    for loopCount in 0...(dndCount - 1) {
    let urlString = BaseUrl + "/" + "\(loopCount + 1)"
    // ****  optional at end will cause program to crash!!!!
    guard let url = URL(string: urlString) else { return moreWeapons}
    
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      if error != nil {
        print(error!.localizedDescription)
      }
      
      guard let data = data else { return }
      
      //Implement JSON decoding and parsing
      do {
        
        //Decode retrived data with JSONDecoder and assing type of Article object...an array of Results
        //let endPointData = try JSONDecoder().decode(DnDResultAPICall.self, from: data) //this was at root endpoint
        let endPointData = try JSONDecoder().decode(EquipmentModel.self, from: data)
        self.moreWeapons.append(endPointData)
        self.pickerNames.append(endPointData.name!)
         print(self.moreWeapons)
        //print(endPointData)
        //Get back to the main queue after # secs
        DispatchQueue.main.async {
         //self.moreWeapons.append(endPointData)
        //this prints all the eequipment pulled (it works)
         // print(self.moreWeapons)
       // self.getTheWeapons()
       //ViewController.pickerView(ViewController) //updateTheLabels()
          // call function in viewcontrolller to change the weaponPicker pickerview
        // this is meant to print just the weapons
         //print(self.weapMod[1])
        //ViewController.pickerView(ViewController.numberOfComponents(<#T##ViewController#>))
        }
        
      } catch let jsonError {
        print(jsonError)
      }
      
     
      }.resume()
    
    }
    return moreWeapons
  }
  
  func getTheWeapons() {
    // this will loop through all the equipment capturing just the weapons
    for count in moreWeapons {
      //instead check equipment_category = to "Weapon"
      if count.weaponCategory != nil {
        // this will append just the weapons
        //pickerData.append(count.name)
        weapMod.append(count)
        print(count)
      }
    }
    
  }
  
}
