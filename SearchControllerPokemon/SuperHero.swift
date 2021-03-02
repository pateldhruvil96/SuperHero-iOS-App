//
//  SuperHero.swift
//  SuperHero App Zoho Assignment
//
//  Created by Dhruvil Patel on 02/03/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit

public class LoadingOverlay
{
    var overlayView: UIView!
    var activityIndiacator: UIActivityIndicatorView!
    var mainView: UIView!
    class var shared: LoadingOverlay {
        struct Static {
            static let instance : LoadingOverlay = LoadingOverlay()
        }
        return Static.instance
    }
    init() {
        DispatchQueue.main.async {
            self.overlayView = UIView()
            self.mainView = UIView()
            self.mainView.frame = UIScreen.main.bounds
            self.activityIndiacator = UIActivityIndicatorView()
            self.overlayView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
            self.overlayView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            self.overlayView.clipsToBounds = true
            self.overlayView.layer.cornerRadius = 10
            self.overlayView.layer.zPosition = 1
            self.activityIndiacator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self.activityIndiacator.center = CGPoint(x: self.overlayView.bounds.width / 2, y: self.overlayView.bounds.height / 2)
            if #available(iOS 13.0, *) {
                self.activityIndiacator.style = .medium
            } else {
                // Fallback on earlier versions
            }
            self.activityIndiacator.color = .white
            self.overlayView.addSubview(self.activityIndiacator)
            self.mainView.addSubview(self.overlayView)
        }
    }
    public func showOverlay(view: UIView) {
        DispatchQueue.main.async {
            self.overlayView.center = view.center
            self.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            view.addSubview(self.mainView)
            self.activityIndiacator.startAnimating()
        }
    }
    public func hideOverlayView() {
        DispatchQueue.main.async {
            self.activityIndiacator.stopAnimating()
            self.overlayView.removeFromSuperview()
            self.mainView.removeFromSuperview()
        }
    }
}

class SuperHero: NSObject {
    
    let name: String
    let image: String
    let element: Element
    let id: String
    
    enum Element: String {
        case Fire
        case Grass
        case Water
        case All
    }
    
    init(name: String, element: Element, imagess:String, id:String) {
        self.name = name
        self.image = imagess
        self.element = element
        self.id = id
        super.init()
    }

}
