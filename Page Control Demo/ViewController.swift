//
//  ViewController.swift
//  Page Control Demo
//
//  Created by Adwait Barkale on 24/12/20.
//  Copyright © 2020 Adwait Barkale. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = UIScrollView()
    let totalPages = 5
    
    var page1: UIView!
    var page2: UIView!
    
    let pageControl : UIPageControl = {
       let pc = UIPageControl()
        pc.backgroundColor = .systemBlue
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        scrollView.backgroundColor = .lightGray
        pageControl.numberOfPages = totalPages
        pageControl.addTarget(self, action: #selector(pageControlDidChanged(_:)), for: .valueChanged)
        view.addSubview(scrollView)
        view.addSubview(pageControl)
    }
    
    @objc func pageControlDidChanged(_ Sender: UIPageControl)
    {
        //print(Sender.currentPage)
        let current = Sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * self.view.frame.size.width, y: 0), animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageControl.frame = .init(x: 10, y: self.view.frame.size.height - 100, width: self.view.frame.size.width - 20, height: 70)
        scrollView.frame = .init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 100)
        
        //ScrollView vertical and horizontal scrolling bar hence subviews are always 2, if made 0 configureScrollView() will not get called.
        if scrollView.subviews.count == 2
        {
            configureScrollView()
        }
    }
    
    func configureScrollView()
    {
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(totalPages), height: scrollView.frame.size.height)
        scrollView.isPagingEnabled = true
        
        let colors : [UIColor] = [
        .systemIndigo,
        .systemGray,
        .systemGreen,
        .systemRed,
        .systemFill
        ]
        
        for x in 0..<5
        {
            
            let currentX = CGFloat(x) * view.frame.size.width
            let page = UIView(frame: CGRect(x: currentX, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
            page.backgroundColor = colors[x]
            
            if x == 0
            {
                page1 = page
            }
            
            if x == 1
            {
                page2 = page
                page2Configuration()
            }
            
            scrollView.addSubview(page)
            
        }
        
    }
    
    //Design UI Programmatically here based on screen this is Page 2
    func page2Configuration()
    {
        page2.backgroundColor = .red
        let lblTitle = UILabel(frame: CGRect(x: 15, y: 100, width: self.view.frame.size.width - 30, height: 50))
        lblTitle.text = "This is Page 2"
        lblTitle.textAlignment = .center
        lblTitle.font = .systemFont(ofSize: 22, weight: .bold)
        lblTitle.textColor = .white
        
        
        page2.addSubview(lblTitle)
    }

}

extension ViewController : UIScrollViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(Float(scrollView.contentOffset.x) / Float(scrollView.frame.size.width))
        
    }
    
}

