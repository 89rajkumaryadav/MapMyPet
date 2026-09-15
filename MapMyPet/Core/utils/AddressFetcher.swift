//
//  AddressFetcher.swift
//  MapMyPet
//
//  Created by Rajkumar Yadav on 15/09/26.
//

import Foundation
import MapKit
internal import Combine

final class AddressFetcher: ObservableObject {
  
    
    @Published var coordinates = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
        latitude: 37.3320003,
        longitude: -122.0307812
      ),
      span: MKCoordinateSpan(
        latitudeDelta: 0.01,
        longitudeDelta: 0.01
      )
    )
    
    private let geocoder = CLGeocoder()
    
    @MainActor
    func search(by address: String) async {
        guard let placemarks = try? await geocoder.geocodeAddressString(address),
          let location = placemarks.first?.location
        else { return }
        coordinates.center = location.coordinate
    }
}
