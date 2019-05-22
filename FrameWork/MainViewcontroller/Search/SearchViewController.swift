//
//  SearchViewController.swift
//  FrameWork
//
//  Created by Jeremy on 5/10/17.
//  Copyright © 2017 fptshop. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Kingfisher
class SearchViewController: UIViewController,UISearchResultsUpdating,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    var products: [Product] = []
    var loadingView:UIView!
    var loading:NVActivityIndicatorView!
    var key:String = ""
    var lbNotFound: UILabel!
    
    weak var handleSearchDelegate: HandleSearch?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(searchAction), name: Notification.Name("searchAction"), object: nil)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: Common.Size(s:10), left: Common.Size(s:5), bottom: Common.Size(s:5), right: Common.Size(s:5))
        
        layout.itemSize = CGSize(width: (self.view.frame.size.width - Common.Size(s:10))/2, height: (self.view.frame.size.width - Common.Size(s:10))/2 * 1.4)
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = Common.Size(s:5)/2
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ProductBonusCollectionCell.self, forCellWithReuseIdentifier: "ProductBonusCollectionCell")
        collectionView.backgroundColor = UIColor.white
        
        self.view.addSubview(collectionView)
        loadingView  = UIView(frame: CGRect(x: 0, y:UIApplication.shared.statusBarFrame.height + Common.MyData.heightNav, width: self.view.frame.size.width, height: self.view.frame.size.height))
        loadingView.backgroundColor = .white
        self.view.addSubview(loadingView)
        //loading
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        loadingView.isHidden = true
        
        let productNotFound = "Không tìm thấy sản phẩm!"
        lbNotFound = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height/2 - Common.Size(s:22), width: self.view.frame.size.width, height: Common.Size(s:22)))
        lbNotFound.textAlignment = .center
        lbNotFound.textColor = UIColor.lightGray
        lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lbNotFound.text = productNotFound
        loadingView.addSubview(lbNotFound)
        lbNotFound.isHidden = true
    }
    func searchAction(notification:Notification) -> Void {
        loadingView.isHidden = false
        self.loadingView.alpha = 1
        lbNotFound.isHidden = true
        APIService.searchProduct(keyword: "\(key)", skip: 0, top: 20) { (results, err) in
            
            self.products = results.sorted(by: { $0.price > $1.price })
            self.collectionView.reloadData()
            
            UIView.animate(withDuration: 0.2, delay: 0.2, options:
                UIViewAnimationOptions.curveEaseOut, animations: {
                    
                    if (results.count > 0){
                        self.loadingView.alpha = 0
                    }
            }, completion: { finished in
                if (results.count <= 0){
                    self.loading.stopAnimating()
                    self.lbNotFound.isHidden = false
                }else{
                    self.loadingView.isHidden = true
                }
            })
            
        }
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
        let item:Product = products[indexPath.row]
        handleSearchDelegate?.pushView(item)
    }
    var isLoading:Bool = false
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height - 100 {
            if (isLoading == false){
                isLoading = true
                APIService.searchProduct(keyword: "\(key)", skip: self.products.count, top: 20) { (results, err) in
                    self.products.append(contentsOf: results)
                    self.collectionView.reloadData()
                    self.isLoading = false
                    print(self.products.count)
                }
            }
            
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.products.removeAll()
        self.collectionView.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
        key =  "\(searchController.searchBar.text!)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        lbNotFound.isHidden = true
        if (key.characters.count <= 0){
            self.products.removeAll()
            self.collectionView.reloadData()
        }else{
            loadingView.isHidden = false
            self.loadingView.alpha = 1
            APIService.searchProduct(keyword: "\(key)", skip: 0, top: 20) { (results, err) in
                
                self.products = results.sorted(by: { $0.price > $1.price })
                self.collectionView.reloadData()
                UIView.animate(withDuration: 0.2, delay: 0.2, options:
                    UIViewAnimationOptions.curveEaseOut, animations: {
                        self.loadingView.alpha = 0
                }, completion: { finished in
                    self.loadingView.isHidden = true
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
class ProductBonusCollectionCell: UICollectionViewCell {
    var iconImage:UIImageView!
    var title:UILabel!
    var price:UILabel!
    var bonus:UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    func setup(item:Product){
        self.subviews.forEach { $0.removeFromSuperview() }
        iconImage = UIImageView(frame: CGRect(x: 0, y:  0, width: self.frame.size.width, height:  self.frame.size.width - Common.Size(s:20)))
        iconImage.contentMode = .scaleAspectFit
        addSubview(iconImage)
        
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] ").inverted)
        
        if let escapedString = item.iconUrl.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print(escapedString)
            let url = URL(string: "\(escapedString)")!
            iconImage.kf.setImage(with: url,
                                  placeholder: nil,
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
        }
        
        let heightTitel = item.name.height(withConstrainedWidth: self.frame.size.width - Common.Size(s:4), font: UIFont.boldSystemFont(ofSize: Common.Size(s:14)))
        
        title = UILabel(frame: CGRect(x: Common.Size(s:2), y: iconImage.frame.size.height + iconImage.frame.origin.y + Common.Size(s:5), width: self.frame.size.width - Common.Size(s:4), height: heightTitel))
        title.textAlignment = .center
        title.textColor = UIColor.lightGray
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        title.text = item.name
        title.numberOfLines = 3
        title.sizeToFit()
        title.frame.origin.x = self.frame.size.width/2 -  title.frame.size.width/2
        addSubview(title)
        price = UILabel(frame: CGRect(x: Common.Size(s:2), y: title.frame.size.height + title.frame.origin.y, width: self.frame.size.width - Common.Size(s:4), height: Common.Size(s:14)))
        price.textAlignment = .center
        price.textColor = UIColor(netHex:0xEF4A40)
        price.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        price.text = Common.convertCurrencyFloat(value: item.price)
        price.numberOfLines = 1
        addSubview(price)
        
        bonus = UILabel(frame: CGRect(x: 2, y: price.frame.size.height + price.frame.origin.y, width: self.frame.size.width - 4, height: Common.Size(s:14)))
        bonus.textAlignment = .center
        bonus.textColor = UIColor(netHex:0x47B054)
        bonus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        bonus.text = "\(item.bonusScopeBoom)"
        bonus.numberOfLines = 1
        addSubview(bonus)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
