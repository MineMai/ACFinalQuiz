//
//  MapVC.swift
//  ACFinalQuiz
//
//  Created by YenShao on 2017/4/28.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    var place:String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //定位設定
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() //開始執行
        
        
        
        if let myplace = place
        {
            setMap(address: myplace)
        }
        
        
    }
    
    
    
    func setMap(address:String)
    {
        let geoCoder = CLGeocoder() //地址轉座標
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            
            if error != nil
            {
                return
            }
            else
            {
                //placemarks裡面傳回來的是可能有好幾個位置，所以用陣列表示
                if let coordinate = placemarks?[0].location?.coordinate
                {
                    //加入大頭針
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    
                    
                    //self.mainMapView.selectAnnotation(annotation, animated: true) //自動顯示泡泡
                    self.mapView.addAnnotation(annotation)
                }
                
            }
            
        }
        
    }
    
    
    
    
    

    

}









