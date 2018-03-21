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

class MapVC: UIViewController {
    
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    
    
    var latValue: Double!
    var longValue: Double!
    var myResto: String!
    
    var restoJson: JSON!
    var markLati:Double!
    var markLong:Double!
    
    //var mapView: GMSMapView!
    

    
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
        
        
        let camera = GMSCameraPosition.camera(withLatitude: latValue!, longitude: longValue!, zoom: 18.0)
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
        //marker.snippet = "San Francisco"
        marker.map = mapView
        
        
        
        
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
