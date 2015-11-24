//
//  GymViewController.swift
//  TarijaGyms
//
//  Created by OLiVeR on 11/23/15.
//  Copyright © 2015 OLiVeR. All rights reserved.
//

import UIKit
import MapKit

class GymViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    //-21.533737, -64.731040 for create my custom point
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var gym: Gym?
    @IBOutlet weak var subtitleTextField: UITextField!
    var myRoute : MKRoute?
    var origin:CLLocationCoordinate2D?
    var destiny:CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Make the initial position of mapkit
        let location = CLLocationCoordinate2D(latitude: -21.533737, longitude: -64.731040)
        let span = MKCoordinateSpanMake(0.020, 0.020)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapView.delegate = self
        mapView.setRegion(region, animated: true)
        
        
        //Make a face position for the pin our position
        let photo = UIImage(named: "Gym1")
        let currentLocation = Gym(title: "Posicion Actual", subtitle: "Posicion Actual de Prueba", photo: photo!, rating: 1)
        currentLocation.color=MKPinAnnotationView.redPinColor()
        currentLocation.coordinate = CLLocationCoordinate2D(latitude: -21.533938, longitude: -64.724643)
        origin = currentLocation.coordinate
        mapView.addAnnotation(currentLocation)
        // Handle the text field’s user input through delegate callbacks.
        nameTextField.delegate = self
        if let gym = gym {
            navigationItem.title = gym.title
            nameTextField.text   = gym.title
            subtitleTextField.text = gym.subtitle
            photoImageView.image = gym.photo
            ratingControl.rating = gym.rating
            destiny = gym.coordinate
            gym.color = MKPinAnnotationView.purplePinColor()
            mapView.addAnnotation(gym)
            destiny = gym.coordinate
        }
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
        let resTemp:Gym = annotation as! Gym
        pinAnnotationView.pinTintColor=resTemp.color
        pinAnnotationView.canShowCallout = true
        pinAnnotationView.animatesDrop = true
        
        return pinAnnotationView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let annotationView = MKPinAnnotationView(annotation: view.annotation, reuseIdentifier: "myPin")
        annotationView.pinTintColor = gym?.color
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let myLineRenderer = MKPolylineRenderer(overlay: overlay)
        myLineRenderer.strokeColor = UIColor.greenColor()
        myLineRenderer.lineWidth = 1
        return myLineRenderer
    }
    
    
    @IBAction func trazarRuta(sender: UIButton) {
         var points: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        if(destiny==nil){
            let alertController = UIAlertController(title: "Mensaje", message:
                "Debes colocar el pin de destino del gimnasio actual", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }else{
            
            points.append(origin!)
            points.append(destiny!)
            
            let polyline = MKPolyline(coordinates: &points, count: points.count)
            mapView.addOverlay(polyline)
            
        }
    }
    
    func mapView(mapView: MKMapView, didAddAnnotationViews views: [MKAnnotationView]) {
        
    }
    
    
    
    
    //MARK Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender{
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let subtitle = subtitleTextField.text ?? ""
            let rating = ratingControl.rating
            gym = Gym(title: name, subtitle: subtitle, photo: photo!, rating: rating)
            
            
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem){
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInGymMode = presentingViewController is UINavigationController
        
        if isPresentingInGymMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        photoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    

    
}
