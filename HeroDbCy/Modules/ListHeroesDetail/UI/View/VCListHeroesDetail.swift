//
//  VCListHeroesDetail.swift
//  HeroDbCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit
////type(melees or range),
//- attribute(agi, str, int)
//- health
//- max attack
//- speed
//- roles
class VCListHeroesDetail: UIViewController {
    @IBOutlet weak var labelStr: UILabel!
    @IBOutlet weak var labelSpd: UILabel!
    @IBOutlet weak var labelHp: UILabel!
    @IBOutlet weak var labelDef: UILabel!
    @IBOutlet weak var labelAgi: UILabel!
    @IBOutlet weak var labelInt: UILabel!
    @IBOutlet weak var labelRoles: UILabel!
    @IBOutlet weak var labelAtk: UILabel!
    @IBOutlet weak var labelArmor: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionview: UICollectionView!
    var eventHandler : PsListHeroesDetail?
    var model: ModelHeroes? {
        didSet {
           
        }
    }
    var modelSimilar: [ModelHeroes]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
        self.setDataToUI()
        self.collectionview.reloadData()
        // Do any additional setup after loading the view.
    }
    

    private func setDataToUI() {
        if let data = self.model {
            self.labelHp.text = String(data.base_health ?? 0)
            self.labelStr.text = String(data.base_str ?? 0)
            self.labelSpd.text = String(data.move_speed ?? 0)
            self.labelDef.text = String(data.base_mana ?? 0)
            self.labelAgi.text = String(data.base_agi ?? 0)
            self.labelInt.text = String(data.base_int ?? 0)
            self.labelAtk.text = data.getStrAtkInfo()
            self.labelArmor.text = String(data.base_armor ?? 0)
            if let url = data.getURlImageFullString() {
                self.img.setImage(url)
            }
            self.navigationItem.title = data.localized_name
            var str = ""
            for role in data.roles! {
                str = str + role + ","
            }
            self.labelRoles.text = str
            
            self.modelSimilar = self.eventHandler?.interactor?.filterSimilarHeroes()
        }
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
  
}


extension VCListHeroesDetail: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CellCollectionHeroes.self), for: indexPath) as! CellCollectionHeroes
        if let data = self.modelSimilar {
            cell.setDataToUI(model: data[indexPath.row], hideTitle: true)
        }
        
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
