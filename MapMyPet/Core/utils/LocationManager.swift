//
//  LocationManager.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import Foundation
import CoreLocation
internal import Combine

final class LocationManager: NSObject, ObservableObject {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    
    private let cllLocationManager: CLLocationManager
    
    init(authorizationStatus: CLAuthorizationStatus = .notDetermined) {
      self.authorizationStatus = authorizationStatus
      self.cllLocationManager = CLLocationManager()
      super.init()
      cllLocationManager.delegate = self
      self.authorizationStatus = cllLocationManager.authorizationStatus
      cllLocationManager.startUpdatingLocation()
    }

    func updateAuthorizationStatus() {
      authorizationStatus = cllLocationManager.authorizationStatus
    }
    
}

// MARK: - Location status
extension LocationManager {
  var locationIsDisabled: Bool {
    authorizationStatus == .denied ||
      authorizationStatus == .notDetermined ||
      authorizationStatus == .restricted
  }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    updateAuthorizationStatus()
  }

  func locationManager(
    _ manager: CLLocationManager,
    didUpdateLocations locations: [CLLocation]
  ) {
    guard let location = locations.first else { return }
    lastSeenLocation = location
  }

  func locationManager(
    _ manager: CLLocationManager,
    didFailWithError error: Error
  ) {
    print("Location retrieving failed due to: \(error.localizedDescription)")
  }
}
