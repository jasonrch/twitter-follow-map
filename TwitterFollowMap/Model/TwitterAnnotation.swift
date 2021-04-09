//
//  TwitterAnnotation.swift
//  TwitterFollowMap
//
//  Created by Julio Reyes on 4/9/21.
//

import UIKit
import MapKit

class TwitterAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String? {
        let st = String(title![title!.index(title!.startIndex, offsetBy: 1)]).capitalized
        return st
    }
    
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    func twitterMapItem() -> MKMapItem {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    

    
}
