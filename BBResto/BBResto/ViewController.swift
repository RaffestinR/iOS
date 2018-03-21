//
//  ViewController.swift
//  BBResto
//
//  Created by tp on 20/03/2018.
//  Copyright © 2018 Vavavax Company. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import GoogleMaps


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var maTable: UITableView!
    var contenu = [""]
    var resto: [JSON] = []
    var restoTuple:[Tuple]=[]
    let locationManager = CLLocationManager()
    var lat: Double = 0
    var long: Double = 0
    var restoJsonTmp: JSON = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maTable.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        
        var userLocation = locationManager.location!.coordinate.latitude
        
        let latitude = locationManager.location!.coordinate.latitude
        let longitude = locationManager.location!.coordinate.longitude
        let distance = 160
        lat = latitude
        long = longitude
        
        let appKey = AppDelegate().appKey
        
       
        let url = URL(string: "https://maps.googleapis.com/maps/api/place/textsearch/json?location=\(latitude),\(longitude)&radius=\(distance)&query=restaurants&key=\(appKey)")
        //print("latitude : \(latitude), longitude : \(longitude), distance : \(distance)")
        
        Alamofire.request(url!).responseJSON { (response) in
            //print("je suis dans alamofire")
            if response.result.isSuccess {
                //print("je suis dans response succes")
                let contenuJSON : JSON = JSON(response.result.value!)
                self.contenu = self.lesCategories(contenuJSON)
                self.maTable.reloadData()
                //print("résult value : \(response.result.value!)")
            }else{
                //print("Erreur : \(response.result.error!)")
            }
        }
        
        
    }
    
    private func lesCategories(_ data: JSON)->[String]{
        var titre = [String]()
        for elt in data["results"].arrayValue {
            titre.append(elt["name"].stringValue)
            //print("TITRE : \(elt["name"].stringValue)")
            resto.append(elt)
            let tuple = Tuple(elt["name"].stringValue,elt["geometry"]["location"]["lat"].doubleValue,elt["geometry"]["location"]["lng"].doubleValue)
            restoTuple.append(tuple)
        }
        return titre
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellule = maTable.dequeueReusableCell(withIdentifier: "idCell", for: indexPath)
        cellule.textLabel?.text = contenu[indexPath.row]
        return cellule
        
    }
    
    var selectedResto: String?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let myResto = self.contenu[indexPath.row]
        print("")
        print("myREsto : \(myResto)")
        //let myRestoLati =
        selectedResto = myResto
        restoJsonTmp = self.resto[indexPath.row]
        
        
        performSegue(withIdentifier: "goToMapSegue", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMapSegue"{
            print("")
            print("INIT")
            let mapVC = segue.destination as! MapVC
            mapVC.restoJson = restoJsonTmp
            print("")
            print("mapVC.restoJson : \(mapVC.restoJson)")
            print("")
            print("mapVC.longValue init : \(mapVC.longValue)")
            print("")
            print("mapVC.latValue init: \(mapVC.latValue)")
            print("")
            mapVC.myResto = selectedResto
            print("mapVC.myResto : \(mapVC.myResto!)")
            mapVC.latValue = lat
            print("")
            print("mapVC.latValue : \(mapVC.latValue!)")
            mapVC.longValue = long
            print("")
            print("mapVC.longValue : \(mapVC.longValue!)")
            print("")
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


