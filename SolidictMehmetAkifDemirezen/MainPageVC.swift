//
//  MainPageVC.swift
//  SolidictMehmetAkifDemirezen
//
//  Created by akif demirezen on 28/12/2017.
//  Copyright © 2017 demirezenOrganization. All rights reserved.
//

import UIKit
import Gemini
import SDWebImage



class MainPageVC: BaseController,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: GeminiCollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var isSearching = false
    var arrayOfSearch = [ResponseModelOfFilms.Movies()]
    var modelFilms = ModelFilms()
    var sendDataToDetail = ResponseModelOfFilms.Movies()
    fileprivate var responseModelFilms = ResponseModelOfFilms(){
        didSet{
            self.tableView.reloadData()
            self.collectionView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavBar(whichPage: "Movie")
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        self.title = "Movie"
        self.modelFilms.filmsDelegate = self
        self.modelFilms.sendDataToService()
        self.indicatorShow(status: true)
        
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.delegate = self
        
        tableView?.register(MoviesTableViewCell.nib, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView?.delegate = self
        tableView?.dataSource = self

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? FilmDetailVC {
            destinationViewController.detailOfMovie = sendDataToDetail
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let indexPath = collectionView.indexPathsForVisibleItems.first{
            
            pageControl.currentPage = indexPath.row
        }
        collectionView.animateVisibleCells()
        scrollView.alwaysBounceHorizontal = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else {
            isSearching = true
            arrayOfSearch = self.responseModelFilms.movies.filter({$0.name.contains(searchBar.text!)})
            tableView.reloadData()
        }
    }
    func setUpNavBar(whichPage : String){
        //For title in navigation bar
        self.navigationController?.view.backgroundColor = UIColor.black
        self.navigationController?.view.tintColor = UIColor.white
        self.navigationItem.title = whichPage
        
    }

   
}
extension MainPageVC : FilmsDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    func getDataSuccessfully(isCorrect: Bool, message: String) {
        if isCorrect{
        print(responseModelFilms.movies[0].name)
            
            pageControl.numberOfPages = responseModelFilms.banners.count
            collectionView?.register(BannerCollectionViewCell.nib, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView.gemini
                .customAnimation()
                .translation(y: 50)
                .rotationAngle(y: 13)
                .ease(.easeOutExpo)
                .shadowEffect(.fadeIn)
                .maxShadowAlpha(0.3)
       self.indicatorShow(status: false)
        }
        else{
         print(message)
        }
    }
    func dataUpdate(responseModel: ResponseModelOfFilms) {
        self.responseModelFilms = responseModel
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell{
            self.collectionView.animateCell(cell)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath as IndexPath) as? BannerCollectionViewCell{
            
      
        
        let imageURL = URL(string: self.responseModelFilms.banners[indexPath.item].url)
            cell.imageViewOfBackground.sd_setImage(with: imageURL)
            cell.labelOfBannerName.text = self.responseModelFilms.banners[indexPath.item].name
            self.collectionView.animateCell(cell)
            return cell
            
        }
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.responseModelFilms.banners.count
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
  
    

}
//Tableview

extension MainPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.3
    }
    
    
}

extension MainPageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier, for: indexPath) as? MoviesTableViewCell {
            if isSearching{
            
                cell.configureWithItem(item: arrayOfSearch,index : indexPath.section)
                cell.selectionStyle = .none
            }
            else{
                cell.configureWithItem(item: self.responseModelFilms.movies,index : indexPath.section)
                cell.selectionStyle = .none
            }
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
      
        if isSearching{
        return self.arrayOfSearch.count
        }
        else{
        return responseModelFilms.movies.count
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            self.sendDataToDetail =  self.arrayOfSearch[indexPath.section]
            
        }
        else{
            self.sendDataToDetail =  self.responseModelFilms.movies[indexPath.section]
            
        }
        
        self.performSegue(withIdentifier: "segueGoToDetail", sender: nil)
        
        
    }
    
}
