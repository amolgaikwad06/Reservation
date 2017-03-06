//
//  PromoContentViewController.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/19/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

class PromoContentViewController: UIViewController
{

     // MARK: - IBOutlet
    
    @IBOutlet weak var promoImageView: UIImageView!
    
    // MARK: - Properties
    
    var pageIndex = 0
    var imageName: String?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let currentImage = imageName
        {
            promoImageView.image = UIImage(named: currentImage)
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

}
