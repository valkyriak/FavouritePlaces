//
//  DetailViewController.swift
//  FavouritePlaces
//
//  Created by Kane Clerke on 8/4/19.
//  Copyright © 2019 Kane Clerke. All rights reserved.
//

import UIKit
import CoreLocation

protocol DetailViewControllerDelegate {
    func okayPressed()
    func cancelPressed()
}

class DetailViewController: UITableViewController, UITextFieldDelegate {
    
    let geo = CLGeocoder()
    var copyOfOGPlace: Places?
    var place: Places?
    var delegate: DetailViewControllerDelegate?
    
//    @IBOutlet weak var nameField: UITextField!
//    @IBOutlet weak var addressField: UITextField!
//    @IBOutlet weak var latitudeField: UITextField!
//    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        saveInModel()
        delegate?.okayPressed()
    }
    func configureView() {
        guard let d = delegate else { return }
        
        nameField.text = place?.name
        addressField.text = place?.address
        latitudeField.text = "\(place!.latitude)"
        longitudeField.text = "\(place!.longitude)"
        
        guard copyOfOGPlace == nil else { return }
        copyOfOGPlace = Places(name: (place?.name)!, address: (place?.address)!, latitude: (place?.latitude)!, longitude: (place?.longitude)!)
        }
    
    func reverseGeoCode(){
        let geo = CLGeocoder()
        let location = CLLocation(latitude: 0.0, longitude: 0.0)
        geo.reverseGeocodeLocation(location){
            guard let places = $0 else {
                print("Error")
                return
            }
            for place in places {
                guard let name = place.name else {
                    print("No name found")
                    continue
                }
                self.nameField.text = place.locality
                self.addressField.text = name
                
            }
        }
        
    }
    
    @IBAction func addressEditingEnd(_ sender: Any) {
        let address = addressField.text!
        
        geo.geocodeAddressString(address) {
            guard let placeMarks = $0 else {
                print("Got Error: \(String(describing: $1))")
                return
            }
            for placeMark in placeMarks {
                guard let location = placeMark.location else {
                    continue
                }
                
                print("got lat: \(location.coordinate.latitude) and Long: \(location.coordinate.longitude) for \(address)")
                let latSearched = location.coordinate.latitude
                let latString = String(latSearched)
                let longSearched = location.coordinate.longitude
                let longString = String(longSearched)
                
                if self.latitudeField.text == "0.0" {
                    self.latitudeField.text = latString
                }
                
                if self.longitudeField.text == "0.0" {
                    self.longitudeField.text = longString
                }
                
            }
        }
    }
    
    

    
    func saveInModel() {
        place?.name = nameField.text ?? ""
        place?.address = addressField.text ?? ""
        guard let text = latitudeField.text,
            let yeet = Double(text) else {
                return }
        place?.latitude = yeet
        
        guard let text2 = longitudeField.text,
            let yeet2 = Double(text2) else {
                return }
        place?.longitude = yeet2
    }

    @IBAction func okayPressed(_ sender: Any) {
        guard let d = delegate else { return }
        d.okayPressed()
    }

//    @IBAction func cancelPressed(_ sender: Any) {
//        guard let copy = copyOfOGPlace else { return }
//        place?.name = copy.name
//        place?.address = copy.address
//        place?.latitude = copy.latitude
//        place?.longitude = copy.longitude
//        configureView()
//        guard let d = delegate else { return }
//        d.cancelPressed()
//    }
    @IBAction func cancelPressed(_ sender: Any) {
                guard let copy = copyOfOGPlace else { return }
                place?.name = copy.name
                place?.address = copy.address
                place?.latitude = copy.latitude
                place?.longitude = copy.longitude
                configureView()
                guard let d = delegate else { return }
                d.cancelPressed()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
