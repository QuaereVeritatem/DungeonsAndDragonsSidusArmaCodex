//
//  ViewController.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/18/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
//Next step 1) read all equipment in through jsondecoder and set as a generic equipment model
//     step 2)  than loop through and set equipment based on equipment-category (use case statement)
//     step 3) display on equipment with equipment-category set as weapon

import UIKit

// remove all logic from this viewcontroller!
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  // variables
  private let dataModel = DataModel()
  var pickerData: [String] = [String]()
  var equipMod = [EquipmentModel]()
  var weaponList: [WeaponListModel.Equipment] = [WeaponListModel.Equipment]()
  var wList: [WeaponListModel] = [WeaponListModel]()
  //var twList = WeaponListModel
  var weapMod = [EquipmentModel]()
  var readyForJSONRUN: Bool = false
  var listOfWeaponListUrls: [String] = [String]()
  var listOfWeaponUrlZ: [String] = [String]()
  var tempInt = 1
  var tempName: String = "BOB"
  private var dataTask: URLSessionDataTask?
  //var tempList: [String]()
  // Main selection PickerView
  @IBOutlet weak var weaponPicker: UIPickerView!
  // Banner under pickerview
  @IBOutlet weak var itemType: UILabel!
  @IBOutlet weak var subType: UILabel!
  @IBOutlet weak var WeaponIcon: UIImageView!
  // Big Banner
  @IBOutlet weak var rangeLabel: UILabel!
  @IBOutlet weak var weaponCategoryLabel: UILabel!
  @IBOutlet weak var damageDiceLabel: UILabel!
  @IBOutlet weak var rangeLong: UILabel!
  @IBOutlet weak var damageValueLabel: UILabel!
  @IBOutlet weak var damageTypeLabel: UILabel!
  @IBOutlet weak var propertyLabel: UILabel!
  @IBOutlet weak var costLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  // reference banner
  @IBOutlet weak var urlLabel: UILabel!
  
  // Create a dispatch group
  let group = DispatchGroup()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Connect data:
    self.weaponPicker.delegate = self
    self.weaponPicker.dataSource = self
    
    //JSON call to get a list of all the weapons website/URLs
    jsonDecodPars()
    
    //self.weaponPicker.reloadAllComponents()
  }
  
  func jsonDecodPars() {
    var tempArray: [String] = [String]()
    //tempArray.append(contentsOf: list)
    
    group.enter()
    //change to a guard let statement
    let url = URL(string: BaseUrl)
    dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
      // handle error
      if let error = error {
        //completion(failure(error))
        print("DataTask error: \(error.localizedDescription)")
        return
      }
        
      guard let response = response as? HTTPURLResponse else {
        // handle empty response
        print("Empty Response")
        return
      }
      print("Response status code: \(response.statusCode)")
        
      guard let data = data else {
        // handle empty data
        print("Empty Data")
        return
      }
      
      //Implement JSON decoding and parsing
      do {
        let endPointData = try JSONDecoder().decode(WeaponListModel.self, from: data)
            self.wList.append(endPointData)
            
            //Get back to the main queue after # secs
            self.group.leave()
          
            // Configure a completion callback
            self.group.notify(queue: .main) {
              // convert WList to real weaponlist(minus header weapon row)
              self.listOfWeaponUrlZ = self.weopListConvert(weaponList: self.wList)
              self.pickerData = self.listOfWeaponUrlZ
              // JSON call to each individual website in the list to get weapon data/info
              self.json2ndPars()
              self.weaponPicker.reloadAllComponents()
            }
          } catch let jsonError {
            //completion(.failure(error))
            print(jsonError)
            }
          }
      dataTask?.resume()
  }

  // 2nd json parse
  func json2ndPars() {
    
    for site in listOfWeaponUrlZ {
      //change to a guard let statement
      let url = URL(string: site)
      dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        // handle error
        if let error = error {
          //completion(failure(error))
          print("DataTask error: \(error.localizedDescription)")
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          // handle empty response
          print("Empty Response")
          return
        }
        print("Response status code: \(response.statusCode)")
        
        guard let data = data else {
          // handle empty data
          print("Empty Data")
          return
        }
        //Implement JSON decoding and parsing
        do {
            let endPointData = try JSONDecoder().decode(EquipmentModel.self, from: data)
          self.weapMod.append(endPointData)
            print("endpointData from just weapMod (2ndParse) is: \(endPointData)")
          
            // Configure a completion callback
            DispatchQueue.main.async {
              self.weaponPicker.reloadAllComponents()
              //need to update after load on main queue (maybe call from the pickerView ****
              self.updateTheLabels(weapon: self.weapMod[0])
            }
          } catch let jsonError {
              //completion(.failure(error))
              print(jsonError)
          }
        }
        dataTask?.resume()
    }
  }
  
  func weopListConvert(weaponList: [WeaponListModel]) -> [String] {
    // this array will return an array of strings (list of all complete weapon urls {no headers})
    var listOfW: [String] = [String]()
    var wL = wList
    
    for oneW in wL[0].equipment {
      let completeUrl = WeaponUrl + oneW.url
      print("The complete Url is : \(completeUrl)")
      listOfW.append(completeUrl)
    }
    return listOfW
  }
  
  /// this will change all the labels to the appropriate json data...we can tie this to a label from pickerview  [Command + Option + /] to do easy comments
  /// - Parameter weapon: EquipmentModel used
  func updateTheLabels(weapon: EquipmentModel) {
    var allPropLabel: String = ""
    let introUrl: String = "dnd5eapi.co"
    let possiblyLong : Int64
    let possiblyProperties: String
    // this will be used as a flag to help populate the weapon with no info
    var weapon123: Bool = false
    
    // for this app itemType should always be Weapon
    itemType.text = weapon.equipmentCategory?.name
    
    // this logic chooses which icon will represent the weapon  (club is default)
    // maybe have special icon for: whip,net,war-pick,scythe, vicious-weapon
    WeaponIcon.image = UIImage(imageLiteralResourceName: "UrlGroup")
    weapon123 = false
    
    if let newIndex = weapon.index {
      
      // checking index name to see if sword icon applies
      let possibleSword = ["sword","dagger","scimitar","rapier","defender","flame-tongue","blade","slayer", "vorpal","frost-brand","holy-avenger","nine-lives-stealer","vicious-weapon","weapon"]
      let combinedSwordResult = possibleSword.contains(where: newIndex.contains)
      if combinedSwordResult {
        WeaponIcon.image = UIImage(imageLiteralResourceName: "sword")
          if newIndex == "weapon" {
          weapon123 = true
        }
      }
      
      // checking index name to see if spear icon applies
      let possibleSpear = ["spear","javelin","lance","pike","trident","halberd"]
      let combinedSpearResult = possibleSpear.contains(where: newIndex.contains)
      if combinedSpearResult {
        WeaponIcon.image = UIImage(imageLiteralResourceName: "spear")
      }
      
      // checking index name to see if club icon applies
      let possibleClub = ["club","bat","staff","whip","rod"]
      let combinedClubResult = possibleClub.contains(where: newIndex.contains)
      if combinedClubResult {
       WeaponIcon.image = UIImage(imageLiteralResourceName: "club")
      }
       
      // checking index name to see if mace icon applies
      let possibleMace = ["mace","morningstar","hammer","glaive","flail","dwarven"]
      let combinedMaceResult = possibleMace.contains(where: newIndex.contains)
      if combinedMaceResult {
       WeaponIcon.image = UIImage(imageLiteralResourceName: "mace")
      }
      
      // checking index name to see if axe icon applies
      let possibleAxe = ["axe","sickle","war-pick","halberd"]
      let combinedAxeResult = possibleAxe.contains(where: newIndex.contains)
      if combinedAxeResult {
       WeaponIcon.image = UIImage(imageLiteralResourceName: "axe")
      }
            
      // checking index name to see if bow icon applies
      let possibleBow = ["bow","arrow","sling","gun","net","dart"]
      let combinedBowResult = possibleBow.contains(where: newIndex.contains)
      if combinedBowResult {
       WeaponIcon.image = UIImage(imageLiteralResourceName: "bow")
      }
      
      // this is the default and in case something new added or we missed a weapon
      if WeaponIcon.image == UIImage(imageLiteralResourceName: "UrlGroup") {
        WeaponIcon.image = UIImage(imageLiteralResourceName: "club")
      }
    }
    
    //make an array of special weapons that have no info so they can all have magic put in for labels/properties
    
    // if non-magical weapon, info filled out so go with JSON...if magical, go with defaults
    if let nonMagicWeapon = weapon.weaponCategory {
      // subtypes are simple, martial, etc
      subType.text = nonMagicWeapon
      //range category label
      rangeLabel.text = weapon.weaponRange
      //short range
      if let possiblyNormal = weapon.range?.normal {
        damageValueLabel.text = String(possiblyNormal)
      }
      //long range
      if let possiblyLong = weapon.range?.long {
        rangeLong.text = String(possiblyLong)
      }
      weaponCategoryLabel.text = weapon.categoryRange
      damageDiceLabel.text =  weapon.damage?.diceCount
      damageTypeLabel.text = weapon.damage?.damageType.name
      if let cQuantity = weapon.cost?.quantity {
        if let cUnit = weapon.cost?.unit {
          costLabel.text  = String(describing: cQuantity) + " " + cUnit
        }
      }
      if let weapWeight = weapon.weight {
        weightLabel.text = String(describing: weapWeight)
      }
      if let goodWeaponProperties = weapon.properties {
        //let lastOne = weapon.properties!.last
        // set only if array isnt nil
        // this logic should be in a function (and not in the VC)
        for pLoop in goodWeaponProperties {
          if let possiblyProperties = pLoop.name {
            allPropLabel.append(possiblyProperties + " ")
            //print(allPropLabel)
          }
        }
      }
    } else {
      let magicWeapon = "Magical"
      subType.text = magicWeapon
      rangeLabel.text = "Magic"
      damageValueLabel.text = "- - -"
      rangeLong.text = "- - -"
      weaponCategoryLabel.text = "Magic"
      damageDiceLabel.text =  "Any"
      damageTypeLabel.text = "All"
      costLabel.text  = "- -" + " " + "GP"
      weightLabel.text = "???"
      allPropLabel = weapon.desc![0]
    }
    propertyLabel.text =  allPropLabel
    
    if let weapUrl = weapon.url {
      let completeUrl = introUrl + weapUrl
      urlLabel.text = completeUrl
    }
  }
  
  // The number of columns of data
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  // The number of rows of data
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    var subCount = 3
    if weapMod.count > 3 {
      subCount = weapMod.count
    } else {
      subCount = weapMod.count
    }
    //print("PickerData.count is: \(pickerData.count)")
    return subCount
  }
  
  // The data to return for the row and component (column) that's being passed in
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    self.weaponPicker.reloadComponent(self.weaponPicker.selectedRow(inComponent: row))
    //print("the pickerData row is: \(pickerData[row])")
    if let weapName = weapMod[row].name {
      pickerData[row] = weapName
      //self.updateTheLabels(weapon: weapMod[row])
    } else {
      pickerData[row] = "Swipe Down For Weapons"
    }
    
    return pickerData[row]
  }

  // Capture the picker view selection
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    
    if let rowName = weapMod[row].name {
      self.updateTheLabels(weapon: weapMod[row])
    }
    weaponPicker.reloadAllComponents()
  }
  
  // change the font in the pickerview to SF UI Text
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    var titleData = "Swipe up to Load Weapons"
    
    if weapMod.count > row {
      if let weapData = weapMod[row].name {
        titleData = weapData
        //self.updateTheLabels(weapon: weapMod[row])
        //print("titleData is weapMod[row].name!    which is \(weapMod[row].name!)")
      }
    }
    
    let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 18.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
    
    return myTitle
  }
  
  // this function designed to take an array and combine all elements into one string
  func getNumbers(array : [String]) -> String {
    // this is bringing in an optional so unwrap safely ****
    let stringArray = array.map{ String($0) }
    return stringArray.joined(separator: ", ")
  }
}

protocol DataModelDelegate: class {
  func didRecieveDataUpdate(data: String)
}

class DataModel {
  weak var delegate: DataModelDelegate?
  func requestData() {
    // the data was received and parsed to String
    let data = "why is this here"
    delegate?.didRecieveDataUpdate(data: data)
  }
}

extension ViewController: DataModelDelegate {
  func didRecieveDataUpdate(data: String) {
  }
}










