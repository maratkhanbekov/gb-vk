import UIKit

class PhotosViewController: UIViewController {
    
    var photosCollectionView: UICollectionView?
    var userPhotos: [String]?

    let vkService = VKService()
    let sessionService = SessionService()
    let dataService = RealmSaveService()
    let photoService = PhotoService()

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView()
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        photosCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        photosCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        photosCollectionView?.backgroundColor = .white

        photosCollectionView?.delegate = self
        photosCollectionView?.dataSource = self
        photosCollectionView?.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)

        view.addSubview(photosCollectionView ?? UICollectionView())
        
        self.view = view

        vkService.getUserPhotos()
            .done { [unowned self] userPhotos in
                self.userPhotos = userPhotos
                self.photosCollectionView?.reloadData()
            }
            .catch { error in
                print(error.localizedDescription)
            }
    }
}


extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        
        guard let url = userPhotos?[indexPath.row] else { return cell }
        
        photoService.photo(url: url) { image in
            cell.groupImageView.image = image
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath)")
    }
    
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
