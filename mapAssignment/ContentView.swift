//
//  ContentView.swift
//  mapAssignment
//
//  Created by Ananya Tandel on 10/10/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default: San Fran
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    // User's search query for location
    @State private var searchQuery = ""
    // Results of the location search
    @State private var searchResults: [MKMapItem] = []

    var body: some View {
        VStack {
            // Map view of the current region
            Map(coordinateRegion: $region, showsUserLocation: true)
                .frame(height: 300)
                .padding()
            
            // search bar
            TextField("Search Location", text: $searchQuery, onCommit: performSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // list display for results
            List(searchResults, id: \.placemark) { result in
                Text(result.placemark.title ?? "")
                    .onTapGesture {
                        updateMapRegion(for: result.placemark.coordinate)
                    }
            }
            // get notification button
            Button("Push to get notification (wait 5 seconds)") {
                getNotification()
            }
        }
    }

    // function to search locations
    func performSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchQuery
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            if let response = response {
                searchResults = response.mapItems
            }
        }
    }

    // update map to show searched location
    func updateMapRegion(for coordinate: CLLocationCoordinate2D) {
        region.center = coordinate
        searchResults = []
    }

    // get notification
    func getNotification() {
        let content = UNMutableNotificationContent()
        content.title = "hello!"
        content.body = "this is a local notification."
        content.sound = UNNotificationSound.default
        content.badge = 1

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

// preview provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



