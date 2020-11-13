import UIKit

class ParsingNewsPostOperation: Operation {
    
    let inputNewsPostFeed: NewsPostFeed
    var outputNewsPosts: NewsPosts?
    
    init(inputNewsPostFeed: NewsPostFeed) {
        self.inputNewsPostFeed = inputNewsPostFeed
        super.init()
    }
    
    override func main() {
        outputNewsPosts = parse()
    }
    
    private func parse() -> NewsPosts {
        
        var posts = [NewsPost]()
        
        inputNewsPostFeed.response?.items?.forEach { inputNewsPost in
        
            let authorInfo = inputNewsPostFeed.response?.groups?.filter({$0.id == -1 * inputNewsPost.sourceID!}).first
            let authorPhoto = authorInfo?.photo200 ?? ""
            let authorName = authorInfo?.name ?? ""
            
            let likesAmount = Int(inputNewsPost.comments?.count ?? 0)
            let commentsAmount = Int(inputNewsPost.comments?.count ?? 0)
            let viewsAmount = Int(inputNewsPost.views?.count ?? 0)
            let repostsAmount = Int(inputNewsPost.reposts?.count ?? 0)
            let postText = inputNewsPost.text ?? ""
            let postAttachments = [""]
            let postPhoto = inputNewsPost.attachments?.first?.photo?.sizes?.last?.url ?? ""
            debugPrint(postPhoto)
            let newsPost = NewsPost(authorPhoto: authorPhoto, authorName: authorName, likesAmount: likesAmount, commentsAmount: commentsAmount, viewsAmount: viewsAmount, repostsAmount: repostsAmount, postText: postText, postAttachments: postAttachments, postPhoto: postPhoto)
            posts.append(newsPost)
        }
        
        let newsPosts = NewsPosts(posts: posts)
        return newsPosts
    }
}
