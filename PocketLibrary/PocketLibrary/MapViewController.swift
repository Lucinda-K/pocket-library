//
//  MapViewController.swift
//  PocketLibrary
//
//  Created by Lucinda Krahl on 4/6/16.
//  Copyright © 2016 Lucinda Krahl. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.mapType = .Standard
        
        
        
    }

}