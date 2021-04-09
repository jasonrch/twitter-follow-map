//
//  ViewController.swift
//  TwitterFollowMap
//
//  Created by Julio Reyes on 4/9/21.
//

import Foundation
import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var twTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        twTableView.dataSource = viewModel
        twTableView.delegate = viewModel
        mapView.delegate = viewModel
        

        
        //Set View Model bindings.
        self.viewModel.bootStrap()
        self.viewModel.reloadTableViewCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.twTableView.reloadData()
            }
        }
        
        self.mapView.addAnnotations((self.viewModel.annotations))

        var coordinates:[CLLocationCoordinate2D] = []
        for annotation in self.viewModel.annotations {
            coordinates.append(annotation.coordinate)
        }
        let region = MKCoordinateRegion.init(coordinates: coordinates)
        mapView.setRegion(region, animated: true)
        
    }


}

