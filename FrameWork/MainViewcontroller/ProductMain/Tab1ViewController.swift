//
//  Tab1ViewController.swift
//  FrameWork
//
//  Created by Jeremy on 5/10/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class Tab1ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{

    
    var collectionView: UICollectionView!
    var products: [Product] = []
    var loadingView:UIView!
    var loading:NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.MyData.tabBarHeight), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductBonusCollectionCell.self, forCellWithReuseIdentifier: "ProductBonusCollectionCell")
        collectionView.backgroundColor = UIColor.white
        //loadingView.addSubview(collectionView)
        self.view.addSubview(collectionView)
        loadingView  = UIView(frame: CGRect(x: 0, y:UIApplication.shared.statusBarFrame.height + Common.MyData.heightNav, width: self.view.frame.size.width, height: self.view.frame.size.height - Common.MyData.tabBarHeight-(UIApplication.shared.statusBarFrame.height + Common.MyData.heightNav)))
        loadingView.backgroundColor = .white
        self.view.addSubview(loadingView)
        //loading
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        
        APIService.getListBonusScope(typeId: 1, skip: 0, top: 20) { (results, err) in
            self.products = results
            self.loadView(results: results)
        }

    }
    func loadView(results: [Product]){
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.reloadData()
        UIView.animate(withDuration: 0.2, delay: 0.2, options:
            UIViewAnimationOptions.curveEaseOut, animations: {
                self.loadingView.alpha = 0
        }, completion: { finished in
            self.loadingView.isHidden = true
            
            //Do anything else that depends on this animation ending
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductBonusCollectionCell", for: indexPath) as! ProductBonusCollectionCell
        let item:Product = products[indexPath.row]
        cell.setup(item: item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell \(indexPath.row)")
    }
    var isLoading:Bool = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height - 100 {
            if (isLoading == false){
                isLoading = true
                APIService.getListBonusScope(typeId: 1, skip: self.products.count, top: 20) { (results, err) in
                    self.products.append(contentsOf: results)
                    self.collectionView.reloadData()
                    self.isLoading = false
                    print(self.products.count)
                }
            }
            
        }
    }

}
