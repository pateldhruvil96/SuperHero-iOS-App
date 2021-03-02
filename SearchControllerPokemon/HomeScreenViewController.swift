//
//  HomeScreenViewController.swift
//  SuperHero App Zoho Assignment
//
//  Created by Dhruvil Patel on 02/03/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    var superHeroNameArray = [String]()
    var superHeroImageArray = [String]()
    var superHeroIdArray = [String]()
    var superHeroID = ["24","2","361","32","429","714","485","239","115","110"]
    
    var i = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        while i < 10{
            api(id: superHeroID[i])
            i+=1
        }
        UserDefaults.standard.set(superHeroID, forKey: "id")
    }
    func api(id:String){
        let loading = LoadingOverlay()
        loading.showOverlay(view: self.view)
        let image = "https://superheroapi.com/api/3382745758497166/\(id)/image"
        let url = URL(string: image)!
        ServerRequest.postcall(url: url, httpMethod: .get, params: nil) { [weak self](response, error) in
            loading.hideOverlayView()
            if let dict = response, dict.count > 0{
                self?.superHeroNameArray.append((dict["name"] as? String)!)
                self?.superHeroImageArray.append((dict["url"] as? String)!)
                UserDefaults.standard.set(self?.superHeroNameArray, forKey: "name")
                UserDefaults.standard.set(self?.superHeroImageArray, forKey: "image")
                
            }
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
