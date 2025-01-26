
import UIKit
import MapKit
import CoreLocation

class DeliveryAddressWithMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    private let locationManager = CLLocationManager()
    private let deliveryAddressView = DeliveryAddressView()
    private let deliveryAddressModel = DeliveryAddressModel()
    private var selectedLocation: CLLocationCoordinate2D?
    var addressCompletion: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)

        view.addSubview(deliveryAddressView)
        deliveryAddressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        setupLocationManager()
        setupMapGesture()
        setupButtonActions()

        deliveryAddressView.addressTextField.delegate = self
        loadSavedLocation()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    private func setupMapGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        deliveryAddressView.mapView.addGestureRecognizer(longPressGesture)
    }

    private func setupButtonActions() {
        deliveryAddressView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        deliveryAddressView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }

    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: deliveryAddressView.mapView)
            let coordinate = deliveryAddressView.mapView.convert(touchPoint, toCoordinateFrom: deliveryAddressView.mapView)
            addAnnotation(at: coordinate)
        }
    }

    private func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        deliveryAddressView.mapView.removeAnnotations(deliveryAddressView.mapView.annotations)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        deliveryAddressView.mapView.addAnnotation(annotation)

        selectedLocation = coordinate

        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                let address = [placemark.thoroughfare, placemark.subThoroughfare, placemark.locality, placemark.postalCode, placemark.country].compactMap { $0 }.joined(separator: ", ")
                self.deliveryAddressView.addressTextField.text = address
            }
        }
    }

    @objc private func saveButtonTapped() {
        guard let selectedLocation = selectedLocation else {
            print("Местоположение не выбрано")
            return
        }
        deliveryAddressModel.saveLocation(coordinate: selectedLocation) { [weak self] success in
            guard let self = self else { return }
            if success, let address = self.deliveryAddressView.addressTextField.text, !address.isEmpty {
                self.addressCompletion?(address)
                self.navigationController?.popViewController(animated: true)
            } else {
                print("Адрес не введен")
            }
        }
    }

    @objc private func searchButtonTapped() {
        guard let address = deliveryAddressView.addressTextField.text, !address.isEmpty else { return }
        searchForAddress(address)
    }

    private func searchForAddress(_ address: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = address
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { [weak self] (response, error) in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка поиска адреса: \(error.localizedDescription)")
                return
            }
            if let response = response, let mapItem = response.mapItems.first {
                let coordinate = mapItem.placemark.coordinate
                self.addAnnotation(at: coordinate)
                let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.deliveryAddressView.mapView.setRegion(region, animated: true)
            }
        }
    }

    private func loadSavedLocation() {
        deliveryAddressModel.loadSavedLocation { [weak self] coordinate in
            guard let self = self, let coordinate = coordinate else { return }
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            self.deliveryAddressView.mapView.setRegion(region, animated: true)
            self.addAnnotation(at: coordinate)
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        deliveryAddressView.mapView.setRegion(region, animated: true)

        addAnnotation(at: location.coordinate)
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка обновления местоположения: \(error.localizedDescription)")
    }

    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Keyboard Handling

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        let bottomInset = keyboardHeight - view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -bottomInset
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
}
