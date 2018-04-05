//
//  MapVC.swift
//  BBResto
//
//  Created by tp on 20/03/2018.
//  Copyright © 2018 Vavavax Company. All rights reserved.
//


import UIKit
import GoogleMaps
import SwiftyJSON
import Alamofire

class MapVC: UIViewController {
    
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    var latValue: Double!
    var longValue: Double!
    var myResto: String!
    
    var restoJson: JSON!
    var markLati:Double!
    var markLong:Double!
    
    
    let polyline = GMSPolyline()
    
    let appKey = AppDelegate().appKey
    //var mapView: GMSMapView!
    enum JSONError: String, Error {
        case NoData = "ERROR: no data"
        case ConversionFailed = "ERROR: conversion from JSON failed"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.myResto = restoJson["name"].stringValue
        
        self.markLati = restoJson["geometry"]["location"]["lat"].doubleValue
        
        self.markLong = restoJson["geometry"]["location"]["lng"].doubleValue
        
        
        print("")
        print("restoJson : \(restoJson)")
        print("")
        print("latValue : \(latValue)")
        print("")
        print("longValue : \(longValue)")
        print("")
        print("myResto : \(myResto)")
        print("")
        print("markLati : \(markLati)")
        print("")
        print("markLong : \(markLong)")
        print("")
        
        
        let camera = GMSCameraPosition.camera(withLatitude: markLati!, longitude: markLong!, zoom: 18.0)
        let mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        mapView.camera = camera
        print("cemara : \(myResto)")
        print("")
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        view = mapView
        
        
        let marker = GMSMarker()
        print("marker pos : \(camera.target)")
        print("")
        marker.position = camera.target
        marker.title = myResto!
        marker.snippet = "Ceci  est un test"
        marker.map = mapView
        
        
        let marker2 = GMSMarker()
        let camera2 = GMSCameraPosition.camera(withLatitude: latValue!, longitude: longValue!, zoom: 18.0)
        print("nous pos : \(camera2.target)")
        print("")
        marker2.position = camera2.target
        marker2.title = "I'm here"
        
        marker2.map = mapView
       
        let urlString = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=\(camera2.target.latitude),\(camera2.target.longitude)&destinations=\(camera.target.latitude),\(camera.target.longitude)&sensor=true&mode=driving&key=\(appKey)"
        Alamofire.request(urlString).responseJSON { (response) in
            print("je suis dans alamofire")
            if response.result.isSuccess {
                print("je suis dans response succes")
                let contenuJSON : JSON = JSON(response.result.value!)
                //self.contenu = self.lesCategories(contenuJSON)
                //self.maTable.reloadData()
                print("résult value : \(response.result.value!)")
            }else{
                print("Erreur : \(response.result.error!)")
            }
        }
        /*
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            do {
                guard let data = data else {
                    throw JSONError.NoData
                }
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    throw JSONError.ConversionFailed
                }
                print(json)
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }
            
        })
        task.resume()
        
        if let array = json["routes"] as? NSArray {
            if let routes = array[0] as? NSDictionary{
                if let overview_polyline = routes["overview_polyline"] as? NSDictionary{
                    if let points = overview_polyline["points"] as? String{
                        print(points)
                        // Use DispatchQueue.main for main thread for handling UI
                        DispatchQueue.main.async {
                            // show polyline
                            let path = GMSPath(fromEncodedPath:points)
                            self.polyline.path = path
                            self.polyline.strokeWidth = 4
                            self.polyline.strokeColor = UIColor.init(hue: 210, saturation: 88, brightness: 84, alpha: 1)
                            self.polyline.map = self.mapView
                        }
                    }
                }
            }
        }
        */
        
 //showMarker(position: camera.target,GMSMapView: mapView)
    }
    
  /*  func showMarker(position: CLLocationCoordinate2D,GMSMapView: mapView){
        let marker = GMSMarker()
        marker.position = position
        marker.title = myResto
        //marker.snippet = "San Francisco"
        marker.map = mapView
    }*/
    
   /*
    override func loadView() {
        self.myResto = self.restoJson["name"].stringValue
        
        self.markLati = self.restoJson["geometry"]["location"]["lat"].doubleValue
        
        self.markLong = self.restoJson["geometry"]["location"]["lng"].doubleValue
        print("")
        print("marker lati pos : \(markLati)")
        print("")
        print("marker long pos : \(markLong)")
        print("")
        let camera = GMSCameraPosition.camera(withLatitude: markLati!, longitude: markLong!, zoom: 2)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.view = mapView
        
    }*/
    
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
extension ViewController: GMSMapViewDelegate{
    /* handles Info Window tap */
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("didTapInfoWindowOf")
    }
    
    /* handles Info Window long press */
    func mapView(_ mapView: GMSMapView, didLongPressInfoWindowOf marker: GMSMarker) {
        print("didLongPressInfoWindowOf")
    }
    
    /* set a custom Info Window */
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 70))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 6
        
        let lbl1 = UILabel(frame: CGRect.init(x: 8, y: 8, width: view.frame.size.width - 16, height: 15))
        lbl1.text = "Hi there!"
        view.addSubview(lbl1)
        
        let lbl2 = UILabel(frame: CGRect.init(x: lbl1.frame.origin.x, y: lbl1.frame.origin.y + lbl1.frame.size.height + 3, width: view.frame.size.width - 16, height: 15))
        lbl2.text = "I am a custom info window."
        lbl2.font = UIFont.systemFont(ofSize: 14, weight: .light)
        view.addSubview(lbl2)
        
        return view
    }
    
    //MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging")
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        //marker.position = coordinate
    }
}
