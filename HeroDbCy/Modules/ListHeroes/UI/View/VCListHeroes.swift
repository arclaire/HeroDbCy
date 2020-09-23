//
//  VCListHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 17/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class VCListHeroes: UIViewController {

    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var table: UITableView!
  
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    var eventHandler : PsListHeroes?
    
    var modelRoles:[String] = [String]() {
        didSet {
            self.table.reloadData()
        }
    }
    
    var model: [ModelHeroes] = [ModelHeroes]() {
        didSet {
            
        }
    }
    
    var modelFiltered: [ModelHeroes] = [ModelHeroes]() {
        didSet {
            self.collectionview.reloadData()
        }
    }
    var indexRowSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setUI()
        self.setUpLocalData()
        self.setUpCollectionView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestData()
    }
    
    func requestData() {
        self.eventHandler?.fetchHeroesData()
    }
    
    private func setUpLocalData() {
        if let model = self.eventHandler?.getRolesData() {
            self.modelRoles = model
        }
    }
    
    private func setupTableView() {
        let nibToRegister = UINib(nibName: String(describing: CellTableRoles.self), bundle: nil)
        self.table.register(nibToRegister, forCellReuseIdentifier: String(describing: CellTableRoles.self))
       
        self.table.delegate = self
        self.table.dataSource = self
        self.table.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.table.separatorInset = .zero
    }
    
    private func setUpCollectionView() {
        
        self.collectionview.delegate = self
        self.collectionview.dataSource = self
        self.collectionview.showsHorizontalScrollIndicator = false
        self.collectionview.showsVerticalScrollIndicator = false
        self.collectionview.backgroundColor = UIColor.white
        self.collectionview.contentInset = UIEdgeInsets.zero
        self.flowLayout.minimumInteritemSpacing = 2
        self.flowLayout.minimumLineSpacing = 2
        //self.collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        let nib = UINib(nibName: String(describing: CellCollectionHeroes.self), bundle: nil)
        self.collectionview.register(nib, forCellWithReuseIdentifier: String(describing: CellCollectionHeroes.self))
    }
    private func setUI() {
        self.navigationItem.title = "All"
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionview.reloadData()
    }

}


//MARK: - TableView
extension VCListHeroes: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelRoles.count //self.modelAlbum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CellTableRoles.self)) as! CellTableRoles
        cell.labelTitle.text = self.modelRoles[indexPath.row]
        if indexPath.row == self.indexRowSelected {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.eventHandler?.goToDetail(index: indexPath.row)
        let str = self.modelRoles[indexPath.row].capitalized
        self.navigationItem.title = str
        self.indexRowSelected = indexPath.row
        self.table.reloadData()
        
        if let data = self.eventHandler?.interactor?.filterModelWith(str: str) {
            self.modelFiltered = data
            self.collectionview.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.view.bounds.size.height / CGFloat(self.modelRoles.count)
        return height
    }
    
    
}


//MARK: - COLLECTION VIEW DATA SOURCE DELEGATE
extension VCListHeroes: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.eventHandler?.goToDetail(model: self.modelFiltered[indexPath.row])
    }
}

extension VCListHeroes: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return modelFiltered.count
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellCollectionHeroes.self), for: indexPath) as! CellCollectionHeroes
        
        cell.setDataToUI(model: self.modelFiltered[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = self.collectionview.bounds.size.width / 4
        if self.collectionview.bounds.width < 400 {
            width = self.collectionview.bounds.size.width / 3
        }
        return CGSize(width: width, height: 100)
    }
}
