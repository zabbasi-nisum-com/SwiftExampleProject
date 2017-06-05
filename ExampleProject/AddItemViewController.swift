//
//  AddItemViewController.swift
//  ExampleProject
//
//  Created by Patrick Sculley on 6/4/17.
//  Copyright © 2017 PixelFlow. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var addBinButton: UIButton!
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var binText: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    var pickerData = [String]()
    var pickerRowSelectedHandler: ((Int) -> Void)?

    
    enum EntityType {
        case Bin
        case Item
        case Location
    }
    
    enum ActionType {
        case Create
        case Update
        case Delete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.title = "Add Item"
        addLocationButton.addTarget(self, action: #selector(addLocationHandler), for: .touchUpInside)
        addBinButton.addTarget(self, action: #selector(addBinHandler), for: .touchUpInside)
        locationText.delegate = self;
        binText.delegate = self;
        picker.delegate = self
        picker.dataSource = self
    }
    
    // MARK: UI Delegates   {
    
    func addLocationHandler(sender: UIBarButtonItem) {
        print("Add location clicked!")
        self.showEditNamePopup(entityType: .Location, actionType: .Create)
    }
    
    func addBinHandler(sender: UIBarButtonItem) {
        print("Add location clicked!")
        self.showEditNamePopup(entityType: .Bin, actionType: .Create)
    }

    func showEditNamePopup(entityType:EntityType, actionType:ActionType)    {
        let alert = UIAlertController(title: "\(actionType) \(entityType)", message: "Enter \(entityType) name", preferredStyle: .alert)
        alert.addTextField { (textField) in textField.placeholder = "\(entityType) name"}
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField.text)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Picker View Data Sources and Delegates
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField == self.locationText)    {
        }
        switch textField {
            case self.locationText:
                self.pickerData = ["Office","Storage Center","Closet","Basement","In use"]
                picker.reloadAllComponents()
                if self.locationText.text != nil && self.locationText.text != ""  {
                    self.picker.selectRow(pickerData.index(of: self.locationText.text!)!, inComponent:0, animated: false)
                }
                else {
                    self.picker.selectRow(0, inComponent:0, animated: false)
            }
            case self.binText:
                self.pickerData = ["Top shelf","Clear drawer #1","Clear drawer #2","Network Cabinet","None"]
                picker.reloadAllComponents()
                if self.binText.text != nil && self.binText.text != ""  {
                    self.picker.selectRow(pickerData.index(of: self.binText.text!)!, inComponent:0, animated: false)
                }
                else {
                    self.picker.selectRow(0, inComponent:0, animated: false)
                }
            default: break
        }

        self.pickerRowSelectedHandler = {(selectedIndex:Int) -> Void in
            var entityType: EntityType?
            switch textField {
                case self.locationText:
                    entityType = EntityType.Location
                    self.locationText.text = self.pickerData[selectedIndex]
                case self.binText:
                    entityType = EntityType.Bin
                    self.binText.text = self.pickerData[selectedIndex]
                default: break
            }
            print("\(entityType) selected: \(selectedIndex)")
        }

        return false;
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerRowSelectedHandler!(row)
    }
    
    // MARK: - Navigation   {
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}