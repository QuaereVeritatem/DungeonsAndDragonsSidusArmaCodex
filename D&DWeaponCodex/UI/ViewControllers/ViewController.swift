//
//  ViewController.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/18/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

  private let dataModel = DataModel()
  
  @IBOutlet weak var weaponPicker: UIPickerView!
  var pickerData: [String] = [String]()
  var equipMod = [EquipmentModel]()
  var weapMod = [EquipmentModel]()
  var tempInt = 1
  
  
  // Banner under pickerview
  @IBOutlet weak var itemType: UILabel!
  @IBOutlet weak var subType: UILabel!
  @IBOutlet weak var damageType: UILabel!
  
  // Big Banner
  @IBOutlet weak var rangeLabel: UILabel!
  @IBOutlet weak var weaponCategoryLabel: UILabel!
  @IBOutlet weak var damageDiceLabel: UILabel!
  @IBOutlet weak var damageValueLabel: UILabel!
  @IBOutlet weak var damageTypeLabel: UILabel!
  @IBOutlet weak var propertyLabel: UILabel!
  @IBOutlet weak var costLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  
  // reference banner
  @IBOutlet weak var urlLabel: UILabel!
  
  //var container = encoder.container(keyedBy: CodingKeys.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    // Connect data:
    self.weaponPicker.delegate = self
    self.weaponPicker.dataSource = self
    
    // Setting up delegate
    dataModel.delegate = self
    dataModel.requestData()
    
    // Input data into the Array:
    //pickerData = []
    
    //equipMod = RequestAndParse.init().reqNParse()
    
    dataModel.requestData()
    
    for loopCount in 0...36 {
      let urlString = BaseUrl + "/" + "\(loopCount + 1)"
      // ****  optional at end will cause program to crash!!!!
      guard let url = URL(string: urlString) else { return }
      
      
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
          self.weapMod.append(endPointData)
          self.pickerData.append(endPointData.name)
          //print(self.pickerData)
          //print(self.weapMod)
          //print(endPointData)
          //Get back to the main queue after # secs
          DispatchQueue.main.async {
            // this calls it everytime..instead lets call when we update(didselectRow)
            //self.updateTheLabels(weapon: endPointData)
          }
          
        } catch let jsonError {
          print(jsonError)
        }
        
        
        }.resume()
      
      
      
    }
    

  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // this will change all the labels to the appropriate json data...we can tie this to a label from pickerview
  func updateTheLabels(weapon: EquipmentModel) {
    
    var allPropLabel: String = ""
    //weaponPicker.reloadAllComponents()
    // *** self.pickerView(weapon.name)
    //self.uuid.text = pickerDataSource[row]
    // self.weaponPicker.dataSource = weapon.name as! UIPickerViewDataSource
   // let title = pickerView(weaponPicker, titleForRow: weapon.index!, forComponent: 0)
    
    itemType.text = weapon.equipmentCategory
    subType.text = weapon.weaponCategory
    damageType.text = String(describing: weapon.index!)
    rangeLabel.text = weapon.weaponRange
    weaponCategoryLabel.text = weapon.categoryRange
    damageDiceLabel.text =  String(describing: weapon.damage!.diceCount)
    damageValueLabel.text =  String(describing: weapon.damage!.diceValue)
    damageTypeLabel.text = weapon.damage?.damageType.name
    
    // I need to change the banner size to make room for an array of properties
    //propertyLabel.text = getNumbers(array: weapon.properties![0])
    for pLoop in weapon.properties! {
      allPropLabel.append(String(describing:pLoop.name) + ". ")
      print(allPropLabel)
    }
     propertyLabel.text =  allPropLabel
    
    costLabel.text  = String(describing: weapon.cost!.quantity) + " " + (weapon.cost!.unit)
    weightLabel.text = String(describing: weapon.weight!)
    urlLabel.text = weapon.url
  }
  
  // The number of columns of data
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  // The number of rows of data
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    // json call is asynchronous so equipmod could be nil when the return hits
    // *** The problem now is UI is loading before JSON finishes downloading ****
    return 37
  }
  
  // The data to return for the row and component (column) that's being passed in
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //let title = weapMod[row]
    
    //return weapMod[weapMod.count - 1].name
    return pickerData[row]
  }

  // Catpure the picker view selection
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    weaponPicker.reloadAllComponents()
    // change labels based on the selection from the pickerview
    self.updateTheLabels(weapon: weapMod[row])
     //print("The count for equipMod is \(equipMod.count)")
  }
  
  // change the font in the pickerview to SF UI Text
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    var titleData = ""
    if weapMod.count > 0 {
    titleData = weapMod[row].name //pickerData[row]
    } else {
      if pickerData.count > 0 {
    titleData = pickerData[row]
      }
      titleData = "Swipe up to Load Weapons"
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

  func getTheWeapons() {
    // this will loop through all the equipment capturing just the weapons
    for count in equipMod {
      if count.weaponCategory != nil {
        // this will append just the weapons
        pickerData.append(count.name)
        weapMod.append(count)
        //print(count.name)
      }
    }
    
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
    //print(data)
  }
}










