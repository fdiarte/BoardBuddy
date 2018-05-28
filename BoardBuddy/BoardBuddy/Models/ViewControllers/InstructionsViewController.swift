//
//  InstructionsViewController.swift
//  BoardBuddy
//
//  Created by James Neeley on 5/28/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class InstructionsViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource,
instructionPagesDelegate {
    
        @IBOutlet weak var pageControl: UIPageControl!

    lazy var subViewController:[UIViewController] = {
        
        let VC1 = UIStoryboard(name: "Instructions", bundle: nil).instantiateViewController(withIdentifier: "Instruction1") as! Instruction1ViewController
        let VC2 = UIStoryboard(name: "Instructions", bundle: nil).instantiateViewController(withIdentifier: "Instruction2") as! Instruction2ViewController
        let VC3 = UIStoryboard(name: "Instructions", bundle: nil).instantiateViewController(withIdentifier: "Instruction3") as! Instruction3ViewController
        let VC4 = UIStoryboard(name: "Instructions", bundle: nil).instantiateViewController(withIdentifier: "Instruction4") as! Instruction4ViewController
        let VC5 = UIStoryboard(name: "Instructions", bundle: nil).instantiateViewController(withIdentifier: "Instruction5") as! Instruction5ViewController
        
        VC5.delegate = self
    
        return [VC1, VC2, VC3, VC4, VC5]
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("page loaded")
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewController[0]], direction: .forward, animated: true) { (success) in
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func gotItButtonPressed() {
        print("delegate works")
        UserDefaults.standard.set(true, forKey: "isCurrentUser")
        let entryStoryBoard = UIStoryboard(name: "EntryScreen", bundle: nil)
        let view = entryStoryBoard.instantiateViewController(withIdentifier: "entryScreen")
        self.present(view, animated: true, completion: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewController.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewController.index(of: viewController) ?? 0
        if currentIndex <= 0 {
            return nil
        }
        return subViewController[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewController.index(of: viewController) ?? 0
        if currentIndex >= subViewController.count - 1 {
            return nil
        }
        return subViewController[currentIndex + 1]
    }
}
