//
//  ViewModel.swift
//  TwitterFollowMap
//
//  Created by Julio Reyes on 4/9/21.
//

import Foundation
import CoreLocation
import MapKit
import UIKit

typealias completion = () -> ()
class ViewModel: NSObject {
    
    var annotations: [TwitterAnnotation] = []
    private var searchResultModel: [TwitterModel]? = nil
    {
        didSet {
            self.reloadTableViewCompletion?()
        }
    }
    var reloadTableViewCompletion: (completion)?

    
    func bootStrap(){
        createTwitterList()
    }
    
    private func createTwitterList(){
        self.searchResultModel = [TwitterModel(twitterHandle: "@MOMA",handleLatitude: "40.761520",handleLongitude: "-73.977630", isFollowing: false),
                                  TwitterModel(twitterHandle: "@LaGuardia",handleLatitude: "40.773415",handleLongitude: "-73.870674", isFollowing: false),
                                  TwitterModel(twitterHandle: "@LCC",handleLatitude: "40.744270",handleLongitude: "-73.937912", isFollowing: false)]
        addAnnotations()
    }
    
    private func addAnnotations() {
        for handle in searchResultModel! {
            if let lat = handle.handleLatitude, let latitude = Double(lat) {
                if let longi  = handle.handleLongitude, let longitude = Double(longi) {
                    let annotation = TwitterAnnotation(title: handle.twitterHandle!, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                    annotations.append(annotation)
                }
            }
        }

    }
}// end viewModel

extension ViewModel: UITableViewDataSource, UITableViewDelegate, FollowButtonsDelegate {
    func followButtonTapped(at index: IndexPath) {
        // Run Twitter API to Follow user
        var followedHandle = searchResultModel?[index.row]
        followedHandle?.isFollowing = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TWCellIdentifier", for: indexPath) as! TWTableViewCell
        
        let currentHandle = searchResultModel![indexPath.row]
        cell.handle = currentHandle
        cell.delegate = self
        cell.indexPath = indexPath

        return cell
    }
    
}

extension ViewModel: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? TwitterAnnotation else { return nil }

        var view: MKMarkerAnnotationView
        
        let identifier = "tw"
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            let detailLabel = UILabel()
            detailLabel.numberOfLines = 2
            detailLabel.font = detailLabel.font.withSize(10)
            detailLabel.text = "Twitter Handle Location"
            
            view.detailCalloutAccessoryView = detailLabel
            
            view.glyphText = annotation.subtitle
            
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.animatesWhenAdded = true
            view.subtitleVisibility = .visible
        }
        
        
        return view
        
    }
}

