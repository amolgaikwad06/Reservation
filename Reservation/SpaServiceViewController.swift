//
//  HomeViewController.swift
//  Reservation
//
//  Created by Amol Gaikwad on 2/19/17.
//  Copyright © 2017 Amol Gaikwad. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class SpaServiceViewController: UIViewController
{
    
    // MARK: - IBOutlet
    @IBOutlet weak var pageView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var massageTableView: UITableView!
    
    @IBOutlet weak var reserveButton: UIButton!
    // MARK: - Properties
    
    var pageViewController: UIPageViewController?
    let arrPageImage = ["image1", "image2", "image3"]
    var currentIndex = 0
    let massageTypesArray = ["Swedish Massage","Deep Tissue Massage","Hot Stone Massage","Reflexology","Trigger Point Therapy"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationItem.title = "SPA SERVICE"
        
        reserveButton.backgroundColor = UIColor.getSelectionBlueColor()
        reserveButton.isEnabled = false

        // Remove the back button
        self.navigationItem.hidesBackButton = true
        // Remove the title of the back button
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:
            .plain, target: nil, action: nil)
        massageTableView.layer.cornerRadius = 10
        
        setPageViewController()
        
               
        //Images automatically scroll infinite
       // Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(SpaServiceViewController.loadNextController), userInfo: nil, repeats: true)

        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private functions
    
    private func setPageViewController()
    {
        let pageVC = self.storyboard?.instantiateViewController(withIdentifier: "promoPageVC") as! UIPageViewController
        pageVC.dataSource = self
        pageVC.delegate = self
        
        let firstController = getViewController(atIndex: 0)
        
        pageVC.setViewControllers([firstController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        
        self.pageViewController = pageVC
        
        self.addChildViewController(self.pageViewController!)
        self.pageView.addSubview(self.pageViewController!.view)
        self.pageViewController?.didMove(toParentViewController: self)

    }
    
    
    fileprivate func getViewController(atIndex index: Int) -> PromoContentViewController
    {
        let promoContentVC = self.storyboard?.instantiateViewController(withIdentifier: "promoContentVC") as! PromoContentViewController
        
        promoContentVC.imageName = arrPageImage[index]
        promoContentVC.pageIndex = index
    
        return promoContentVC
    }
    
    /*@objc fileprivate func loadNextController()
    {
        currentIndex += 1
        
        if currentIndex == arrPageImage.count
        {
            currentIndex = 0
        }
        
        if currentIndex == 0 || currentIndex == 2 || currentIndex == 3
        {
            reserveButton.backgroundColor = UIColor.getSelectionBlueColor()
            reserveButton.isEnabled = false
        }
        else
        {
            reserveButton.backgroundColor = UIColor.getCustomBlueColor()
            reserveButton.isEnabled = true
        }
        
        let nextController = getViewController(atIndex: currentIndex)
        self.pageViewController?.setViewControllers([nextController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
        self.pageControl.currentPage = currentIndex
    }*/
    
    // MARK: - @IBAction Methods
    
    @IBAction func didSelectReserveButton(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "spaServiceSegue", sender: self)
    }
    
}

// MARK: - UIPageViewControllerDatasource

@available(iOS 10.0, *)
extension SpaServiceViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        if index == 0 || index == NSNotFound
        {
            return getViewController(atIndex: arrPageImage.count - 1)
            
        }
        
        index -= 1
        
        return getViewController(atIndex: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        
        let pageContentVC = viewController as! PromoContentViewController
        var index = pageContentVC.pageIndex
        
        if index == NSNotFound
        {
            return nil
        }
        
        index += 1
        
        if index == arrPageImage.count
        {
            return getViewController(atIndex: 0)
        }
        
        return getViewController(atIndex: index)
    }
    
    // MARK : - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("willTransitionTo")
        currentIndex = (pendingViewControllers.first as! PromoContentViewController).pageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("didFinishAnimating")
        self.pageControl.currentPage = currentIndex
        enableOrDisableReserveButton()
        
    }
    
    func enableOrDisableReserveButton(){
        if currentIndex == 0 || currentIndex == 2 || currentIndex == 3
        {
            reserveButton.backgroundColor = UIColor.getSelectionBlueColor()
            reserveButton.isEnabled = false
        }
        else
        {
            reserveButton.backgroundColor = UIColor.getCustomBlueColor()
            reserveButton.isEnabled = true
        }
    }
}

// MARK: - UITableViewControllerDatasource

@available(iOS 10.0, *)
extension SpaServiceViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return massageTypesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = massageTypesArray[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        return cell
    }
}

// MARK: - UITableViewControllerDelegate

@available(iOS 10.0, *)
extension SpaServiceViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 2 && currentIndex == 1
        {
            //Segue to the second view controller
            self.performSegue(withIdentifier: "spaServiceSegue", sender: self)
        }
    }
}


