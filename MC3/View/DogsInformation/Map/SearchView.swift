//
//  SearchView.swift
//  MC3
//
//  Created by Jeffri Lieca H on 18/07/24.
//

import SwiftUI
import MapKit

struct SearchView: View {
    @StateObject var locationManager: LocationManager = .init()
    // MARK: Navigation Tag to Push View to MapView
//    @Binding var searchText : String
    @State var navigationTag : String?
    @State var isShow = false
    @Binding var isShowingLocationModal : Bool
    @Binding var isShowingLocationModa2 : Bool
    @Binding var dogLocation : String
    @Binding var dogCoordinate : CLLocation
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack{
                HStack(spacing: 15){
//                    Button{
//                        
//                    } label: {
//                        Image(systemName: "chevron.left")
//                            .font(.title3)
//                            .foregroundStyle(.primary)
//                    }
                    Text("Enter Your Dog's Location")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                HStack(spacing: 10){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Find locations here",text: $locationManager.searchText)
                }
                .padding(.vertical,12)
                .padding(.horizontal)
                .background{
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .strokeBorder(.gray)
                }
                .padding(.vertical,10)
                
                if let places = locationManager.fetchedPlaces, !places.isEmpty{
                    List{
                        ForEach(places, id: \.self){place in
                            Button {
                                if let coordinate = place.location?.coordinate{
                                    locationManager.dogLocation = .init(latitude: coordinate.latitude, longitude: coordinate.longitude)
                                    locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                                    locationManager.addDraggablePin(coordinate: coordinate)
                                    locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                                    
                                    // MARK: Navigating to MapView
                                    navigationTag = "MAPVIEW"
                                    isShow=true
                                    isShowingLocationModa2 = true
                                    print("clicked")
                                }
                                
                                
                            } label: {
                                HStack(spacing: 15){
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                    VStack(alignment: .leading, spacing: 6 ) {
                                        Text(place.name ?? "")
                                            .font(.title3.bold())
                                            .foregroundColor(.primary)
                                        Text(place.locality ?? "")
                                            .font(.caption)
                                            .foregroundStyle(.gray)
                                    }
                                }
                                
                            }
                            
                            
                        }
                    }
                    
                }
                else{
                    // MARK: Live Location Button
                    Button {
                        
                        // MARK: Setting Map Region
                        if let coordinate = locationManager.userLocation?.coordinate{
                            locationManager.mapView.region = .init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                            locationManager.addDraggablePin(coordinate: coordinate)
                            locationManager.updatePlacemark(location: .init(latitude: coordinate.latitude, longitude: coordinate.longitude))
                        }
                        
                        // MARK: Navigating to MapView
                        navigationTag = "MAPVIEW"
                        isShow=true
                        isShowingLocationModa2 = true
                        print("clicked")
                    } label: {
                        Label {
                            Text("Use Current Location")
                                .font(.callout)
                        } icon: {
                            Image(systemName: "location.north.circle.fill")
                        }
                        .foregroundColor(.green)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                }
            }
            .navigationTitle("Dog's Location")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                }
                            }
                        }
                        .padding()
                        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .top)
        }
        
//        .background{
//            NavigationLink(tag: "MAPVIEW", selection: $navigationTag) {
//                MapViewSelection()
//                    .environmentObject(locationManager)
//            } label: {
//            }
//            .labelsHidden()
//        }
        .sheet(isPresented: $isShowingLocationModa2, content: {
            MapViewSelection(isShowingLocationModal: $isShowingLocationModal, isShowingLocationModa2: $isShowingLocationModa2, dogLocation: $dogLocation, dogCoordinate: $dogCoordinate)
                                .environmentObject(locationManager)
                                .navigationBarHidden(true)
               })
        
    }
}

//#Preview {
//    @State var isShowingLocationModal = false
//    @State var isShowingLocationModa2 = false
//    SearchView(isShowingLocationModal: $isShowingLocationModal, isShowingLocationModa2: $isShowingLocationModa2)
//}

// MARK: MapView Live Selection
struct MapViewSelection: View {
    @Binding var isShowingLocationModal : Bool
    @Binding var isShowingLocationModa2 : Bool
    @Binding var dogLocation : String
    @Binding var dogCoordinate : CLLocation
    @EnvironmentObject var locationManager: LocationManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            MapViewHelper()
                .environmentObject(locationManager)
                .ignoresSafeArea()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2.bold())
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity,alignment: .topLeading)
            // MARK: Displaying Data
            if let place =  locationManager.dogPlaceMark{
                VStack(spacing: 15){
                    Text("Confirm Location")
                        .font(.title2.bold())
                    
                    HStack(spacing: 15){
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading, spacing: 6 ) {
                            Text(place.name ?? "")
                                .font(.title3.bold())
                            Text(place.locality ?? "")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                    .padding(.vertical,10)
                    
                    Button{
                        isShowingLocationModal = false
                        isShowingLocationModa2 = false
                        if let name = locationManager.dogPlaceMark?.name,
                           let locality = locationManager.dogPlaceMark?.locality {
                            dogLocation = "\(name) \(locality)"
                        } else if let name = locationManager.dogPlaceMark?.name {
                            dogLocation = name
                        } else if let locality = locationManager.dogPlaceMark?.locality {
                            dogLocation = locality
                        } else {
                            dogLocation = "Location not available"
                        }
                        if let coor = locationManager.dogLocation{
                            dogCoordinate = coor
                        }

                        
                    }label: {
                        Text("Confirm Location")
                            .fontWeight(.semibold)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .padding(.vertical,12)
                            .background{
                                RoundedRectangle(cornerRadius: 10,style: .continuous).fill(.green)
                                }
                                .overlay(alignment: .trailing){
                                    Image(systemName: "arrow.right")
                                        .font(.title3.bold())
                                        .padding(.trailing)
                                }
                                .foregroundColor(.white)
                    }
                }
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .fill(.white)
                        .ignoresSafeArea()
                }
                .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .bottom)
            }
        }
        .onDisappear{
            locationManager.dogLocation = nil
            locationManager.dogPlaceMark = nil
            
            locationManager.mapView.removeAnnotations(locationManager.mapView.annotations)
        }
    }
}

// MARK: UIKit MapView
struct MapViewHelper: UIViewRepresentable{
    @EnvironmentObject var locationManager: LocationManager
    func makeUIView(context: Context) -> MKMapView {
        return locationManager.mapView
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
