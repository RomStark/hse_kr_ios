//
//  MapViewController.swift
//  hse_kr_ios
//
//  Created by Al Stark on 09.04.2023.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewable: AnyObject {
    
}
final class MapViewController: UIViewController {
    private let charityStorage = CharityStorage.shared
    private let map = MKMapView()
    private var locationManager = CLLocationManager()
    private var locations = [CharityClass]() {
        didSet {
            AddAnnotations()
            
        }
    }
    private var charities = Dictionary<String, Charity>()
    private var selfCoordinate = CLLocationCoordinate2D()
    var presenter: MapPresentation?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        setupLocationManager()
        getLocations()
        
    }
    
    

}

private extension MapViewController {
    private func AddAnnotations() {
        for charity in self.locations {
            if charity.coordinate.longitude == 0 {
                continue
            }
            self.map.addAnnotation(charity)
        }
    }
    private func getLocations() {
        presenter?.getCharityLocations(completion: { [weak self] result in
            switch result {
            case .success(let charityLocations):
                
                guard let self = self,
                      let charities = charityLocations as? Dictionary<String, [Double]> else {
                    return
                }
                var charitiesList = [CharityClass]()
                for i in charities.keys {
                    guard let charity = self.charityStorage.charities[i] else {continue}
                    
                    let charityClass = CharityClass(id: i, coordinate: CLLocationCoordinate2D(latitude: charities[i]?[0] ?? 0.0, longitude: charities[i]?[1] ?? 0.0))
                    charityClass.name = charity.name
                    charitiesList.append(charityClass)
                }
                print("controller")
                DispatchQueue.main.async {
                    self.locations = charitiesList
                }
               
                
            case .failure(let failure):
                print("все плохо")
            }
        })
    }
    private func setupMap() {
        view.addSubview(map)
        map.delegate = self
        map.translatesAutoresizingMaskIntoConstraints = false
        map.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        map.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        map.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        map.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        map.showsUserLocation = true
        print(map.userLocation.location?.coordinate.latitude)
        if let coordinate = map.userLocation.location?.coordinate {
            print(coordinate.latitude)
            let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            map.setRegion(viewRegion, animated: false)
        }
       
        
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        if let userLocation = locationManager.location?.coordinate {
            print(userLocation.latitude)
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            map.setRegion(viewRegion, animated: false)
        }
        
        
        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CharityClass else { return nil}
        var viewMarker: MKMarkerAnnotationView
        let idView = "marker"
        if let view = map.dequeueReusableAnnotationView(withIdentifier: idView) as? MKMarkerAnnotationView {
            view.annotation = annotation
            viewMarker = view
        } else {
            viewMarker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: idView)
            viewMarker.canShowCallout = true
            viewMarker.calloutOffset = CGPoint(x: 0, y: 5)
            viewMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }

        return viewMarker
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let charity = view.annotation as! CharityClass
        
        if let charityModel = charityStorage.charities[charity.id] {
            let vc = CharityInfoViewController()
            vc.configure(charity: charityModel)
            if let sheet = vc.sheetPresentationController{
                sheet.detents = [.medium(), .large()]
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersGrabberVisible = true
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.preferredCornerRadius = 20
            }
            present(vc, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        guard let coordinate = locationManager.location?.coordinate else { return }

        map.removeOverlays(map.overlays)

        let charity = view.annotation as! CharityClass
        let startPoint = MKPlacemark(coordinate: coordinate)
        let endPoint = MKPlacemark(coordinate: charity.coordinate)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: endPoint)
        request.transportType = .automobile

        let direction = MKDirections(request: request)

        direction.calculate { [weak self] response, error in

            guard let self else { return }

            guard let response = response else { return }

            for route in response.routes {
                self.map.addOverlay(route.polyline)
            }
        }

    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 4
        return renderer
    }
}

extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let coordinate: CLLocationCoordinate2D = manager.location?.coordinate else {
//            return
//        }
//        selfCoordinate.latitude = coordinate.latitude
//        selfCoordinate.longitude = coordinate.longitude
//        
//        let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
//        map.setRegion(viewRegion, animated: false)
//        
//    }
}

//MARK: MapViewable
extension MapViewController: MapViewable {
    
}


