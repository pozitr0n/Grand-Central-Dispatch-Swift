//
//  SpinnerViewController.swift
//  GCD
//
//  Created by Raman Kozar on 09/02/2023.
//

import UIKit

class SpinnerViewController: UIViewController {

    let rectangleView = UIView()
    let spinner = UIActivityIndicatorView(style: .large)
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = UIColor(white: 0.7, alpha: 0.8)
        
        rectangleView.backgroundColor = .lightGray
        rectangleView.layer.cornerRadius = 15
        rectangleView.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
        view.addSubview(rectangleView)
        
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        rectangleView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        rectangleView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        rectangleView.addSubview(spinner)
        spinner.color = .white
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        label.text = "Loading chat..."
        label.textColor = .white
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        rectangleView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor, constant: 0).isActive = true
        label.topAnchor.constraint(equalTo: spinner.bottomAnchor, constant: 10).isActive = true
        
    }
    
}
