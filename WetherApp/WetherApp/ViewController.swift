//
//  ViewController.swift
//  WetherApp
//
//  Created by Кирилл on 2/18/21.
//
import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var townLabel: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var ceilcLabel: UILabel!
    @IBOutlet weak var imageStatus: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        backgroundView.layer.addSublayer(gradientLayer)
        
    }
    
  
    func setBlueGradientBackground(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setGreyGradientBackground(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(searchBar.text!)&appid=618d5a756ac5aa0b8f39201f28346146"
        let url = URL(string: urlString)
        
        var locationName: String?
        var temp: String?
        var weatherText: String?
        var weatherImage: UIImage?
        
        let task = URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    as! [String : AnyObject]
                
                if let location = json["city"] {
                    locationName = location["name"] as? String
                    
                }
                
                let array = (json["list"] as? Array<[String : AnyObject]>)?.last
                
                
                let firstDay = (json["list"] as? Array<[String : AnyObject]>)?.last
                
                if let tempDouble = firstDay?["main"]?["temp"] as? Double {
                    temp = String(format: "%.0f", tempDouble - 273.15)
                }
                
                let weather = (firstDay?["weather"] as? Array<[String : AnyObject]>)?.last
                
                if let time = array?["dt"] as? Double{
                    
                }
                
                if let weatherTitle = weather?["main"] as? String,
                   let weatherDescr = weather?["description"] as? String {
                    weatherText = [weatherTitle, weatherDescr].joined(separator: ", ")
                }
                
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                
                
                
                if let iconName = weather?["icon"] as? String,
                   let image = UIImage(named: iconName) {
                    weatherImage = image
                }
                
                DispatchQueue.main.async {
                    self?.dayLabel.isHidden = false
                    self?.ceilcLabel.isHidden = false
                    self?.townLabel.isHidden = false
                    self?.townLabel.text = locationName
                    self?.tempLabel.text = temp
                    self?.weatherStatus.isHidden = false
                    self?.weatherStatus.text = weatherText
                    self?.imageStatus.image = weatherImage
                    self?.dayLabel.text = dateFormatter.string(from: date)
                }
                
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
    }
    
}
