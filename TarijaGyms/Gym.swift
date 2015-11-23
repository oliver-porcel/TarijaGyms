//
//  Gym.swift
//  TarijaGyms
//
//  Created by OLiVeR on 11/23/15.
//  Copyright © 2015 OLiVeR. All rights reserved.
//

import UIKit
import MapKit


class Gym:  NSObject,MKAnnotation{
    
    
    var title: String?
    var subtitle:String?
    var photo:UIImage
    var rating:Int
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    var custom_image: Bool = true
    var color:UIColor = MKPinAnnotationView.greenPinColor()
    
    
    init(title:String, subtitle:String,  photo:UIImage, rating:Int, coordinate:CLLocationCoordinate2D) {
        self.title=title
        self.subtitle=subtitle
        self.photo=photo
        self.rating=rating
        self.coordinate=coordinate
    }
    init(title:String,subtitle:String, photo:UIImage, rating:Int) {
        self.title=title
        self.subtitle=subtitle
        self.photo=photo
        self.rating=rating
    }
    
    
}
