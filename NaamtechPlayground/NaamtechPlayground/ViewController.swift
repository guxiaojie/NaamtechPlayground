//
//  ViewController.swift
//  NaamtechPlayground
//
//  Created by Guxiaojie on 20/03/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!

    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
        self.view.backgroundColor = UIColor.white
        self.title = "Playground"
        //add an collection view to organize the test
        commonInit()
        setupConstraint()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func commonInit() {
        let flowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
    
    func setupConstraint() {
        //constraint collectionView
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        let viewsDictionary = ["contentView": collectionView] as [String : Any]
        let constraintV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[contentView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let constraintH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[contentView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        view.addConstraints(constraintH)
        view.addConstraints(constraintV)
    }

}


extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TitleCollectionViewCell
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Given an input with a string, use recursion to find the first position letter a is on."
        case 1:
            cell.titleLabel.text = "Write a program where, given a number of random string, it will output the calculated result as a report."
        case 2:
            cell.titleLabel.text = "Write a calculator which takes in a number of string input and perform calculation."
        default:
            cell.titleLabel.text = "Waiting for more"
        }
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = DetailsViewController()
        switch indexPath.row {
        case 0:
            viewController.problem = Problem.postion
        case 1:
            viewController.problem = Problem.numberReport
        case 2:
            viewController.problem = Problem.calculator
        default:
            viewController.problem = Problem.postion
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 100)
    }
    
}
