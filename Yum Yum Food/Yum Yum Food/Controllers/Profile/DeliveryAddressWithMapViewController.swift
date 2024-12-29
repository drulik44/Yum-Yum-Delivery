import UIKit
import MapKit
import CoreLocation
import SnapKit
import FirebaseFirestore
import FirebaseAuth
import SkyFloatingLabelTextField

class DeliveryAddressWithMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {

    var addressCompletion: ((String) -> Void)?

    
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let addressLabel = UILabel()
    private var selectedLocation: CLLocationCoordinate2D?
    private let user = Auth.auth().currentUser
    
    private let addressTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.configureBorderTextField(
            placeholder: "   Enter your address",
            tintColor: AppColors.backgroundCell,
            textColor: AppColors.textColorMain,
            borderColor: AppColors.gray,
            selectedBorderColor: AppColors.main,
            cornerRadius: 15.0
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = .Rubick.bold.size(of:20)
        button.setTitleColor(AppColors.backgroundCell, for: .normal)
        button.backgroundColor = AppColors.main
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Search"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.layer.cornerRadius = 20
        
        if let originalImage = UIImage(named: "Search") {
            let resizedImage = originalImage.resized(to: CGSize(width: 30, height: 30))
            button.setImage(resizedImage, for: .normal)
        }
        
        
        
        
        
        return button
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        navigationController?.setupCustomBackButton(for: self)

        setupUI()
        setupConstraints()
        setupLocationManager()
        setupMapGesture()
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        loadSavedLocation()
    }

    //MARK: - Setup UI

    private func setupUI() {
        mapView.delegate = self
        view.addSubview(mapView)

        addressLabel.text = "Address"
        addressLabel.font = .Rubick.bold.size(of: 18)
        view.addSubview(addressLabel)

        
        addressTextField.delegate = self
        view.addSubview(addressTextField)

        
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        view.addSubview(searchButton)

        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.addSubview(saveButton)
    }

    
    //MARK: - Setup constraints

    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(550)
        }

        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }

        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-80)
            make.height.equalTo(40)
        }

        searchButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.top)
            make.left.equalTo(addressTextField.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(addressTextField.snp.height)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Запрос разрешений на использование местоположения
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()

        locationManager.startUpdatingLocation()
    }
    
    private func setupMapGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        mapView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            addAnnotation(at: coordinate)
        }
    }

    private func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        // Удаляем все предыдущие аннотации
        mapView.removeAnnotations(mapView.annotations)
        
        // Добавляем новую аннотацию
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        selectedLocation = coordinate
        
        // Обратное геокодирование для получения адреса
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
                self.addressTextField.text = address
            }
        }
    }

    @objc private func saveButtonTapped() {
        guard let selectedLocation = selectedLocation else {
            print("Местоположение не выбрано")
            return
        }
        saveLocationToFirebase(coordinate: selectedLocation)
        print("Адрес сохранён: \(selectedLocation.latitude), \(selectedLocation.longitude)")
        if let address = addressTextField.text, !address.isEmpty {
                  addressCompletion?(address) // Передача адреса через замыкание
                  navigationController?.popViewController(animated: true) // Возврат назад
              } else {
                  print("Адрес не введен")
              }
          }
    
    
    @objc private func searchButtonTapped() {
        guard let address = addressTextField.text, !address.isEmpty else { return }
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
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    private func saveLocationToFirebase(coordinate: CLLocationCoordinate2D) {
        guard let user = user else { return }
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        userRef.updateData([
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude
        ]) { error in
            if let error = error {
                print("Ошибка сохранения местоположения: \(error.localizedDescription)")
            } else {
                print("Местоположение успешно сохранено в Firestore")
            }
        }
    }
    
    private func loadSavedLocation() {
        guard let user = user else { return }
        let userRef = Firestore.firestore().collection("users").document(user.uid)
        userRef.getDocument { [weak self] (document, error) in
            guard let self = self else { return }
            if let error = error {
                print("Ошибка загрузки местоположения: \(error.localizedDescription)")
                return
            }
            if let document = document, document.exists {
                if let latitude = document.data()?["latitude"] as? CLLocationDegrees,
                   let longitude = document.data()?["longitude"] as? CLLocationDegrees {
                    let savedCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    let region = MKCoordinateRegion(center: savedCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    self.mapView.setRegion(region, animated: true)
                    self.addAnnotation(at: savedCoordinate)
                }
            }
        }
    }

    // MARK: - CLLocationManagerDelegate

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        // Устанавливаем маркер на текущем местоположении пользователя
        addAnnotation(at: location.coordinate)
        
        // Останавливаем обновление местоположения после получения начальной координаты
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Ошибка обновления местоположения: \(error.localizedDescription)")
    }
}

