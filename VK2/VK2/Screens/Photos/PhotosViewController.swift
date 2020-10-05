import UIKit

class PhotosViewController: UIViewController {
    
    var photosCollectionView: UICollectionView?
    var data: [Int] = Array(0..<10)
    
    let vkService = VKService()

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView()
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        photosCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        photosCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
        photosCollectionView?.backgroundColor = .red

        photosCollectionView?.delegate = self
        photosCollectionView?.dataSource = self
        photosCollectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)

        view.addSubview(photosCollectionView ?? UICollectionView())
        
        self.view = view
        
//        guard let userId = SessionManager.instance.user?.usedId, let accessToken = SessionManager.instance.user?.accessToken else {return}
//        vkService.getUserInfo(userId: userId, accessToken: accessToken)

    }
}
