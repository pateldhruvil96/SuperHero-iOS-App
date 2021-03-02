//
//  SelectedViewController.swift
//  SuperHero App Zoho Assignment
//
//  Created by Dhruvil Patel on 02/03/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit

class SelectedViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var intelligence: UILabel!
    @IBOutlet weak var strength: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var durability: UILabel!
    @IBOutlet weak var power: UILabel!
    @IBOutlet weak var combat: UILabel!
    var id:String?
    var imageString : String?
    var heroName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 8.2, *) {
            self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .semibold),NSAttributedString.Key.foregroundColor: UIColor.black]
        } else {
            // Fallback on earlier versions
        }
        self.navigationItem.title = heroName
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        fetching()
    }
    func fetching(){
        let loading = LoadingOverlay()
        loading.showOverlay(view: self.view)
        let image = "https://superheroapi.com/api/3382745758497166/\(id ?? "1")/powerstats"
        let url = URL(string: image)!
        ServerRequest.postcall(url: url, httpMethod: .get, params: nil) { [weak self](response, error) in
            loading.hideOverlayView()
            if let dict = response, dict.count > 0{
            
                self?.profileImage.kf.setImage(with: URL(string: self!.imageString!))
                self?.intelligence.text = "Intelligence: \(dict["intelligence"] as? String ?? "")"
                self?.strength.text = "Strength: \(dict["strength"] as? String ?? "")"
                self?.speed.text =  "Speed: \(dict["speed"] as? String ?? "")"
                self?.durability.text =  "Durability: \(dict["durability"] as? String ?? "")"
                self?.power.text =  "Power: \(dict["power"] as? String ?? "")"
                self?.combat.text =  "Combat: \(dict["combat"] as? String ?? "")"
            }
        }
    }
   
}
