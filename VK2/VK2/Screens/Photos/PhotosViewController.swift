import UIKit

class PhotosViewController: UIViewController {
    
    var photosCollectionView: UICollectionView?
    var userPhotos: [String]?
    
    let vkService = VKService()
    let sessionService = SessionService()

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

        // Загружаем данные
        guard let userId = sessionService.getUsedId(), let accessToken = sessionService.getToken() else { return }
        vkService.getUserPhotos(userId: userId, accessToken: accessToken, callback: { [weak self] userPhotos in
            
            self?.userPhotos = userPhotos
            self?.photosCollectionView?.reloadData()
            
        })

    }
}
