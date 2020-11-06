import UIKit

extension NewsViewController: UITableViewDelegate {
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width + 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        let newsPost = NewsPost(authorPhoto: "spongeBob", authorName: "Spongebob", likesAmount: 10, commentsAmount: 5, viewsAmount: 20, repostsAmount: 3, postText: "La serie narra las aventuras y los esfuerzos del personaje del título y sus diversos amigos en la ficticia ciudad submarina de Fondo de Bikini. Es la quinta serie animada estadounidense de más larga duración, su popularidad la ha convertido en una franquicia, así como la serie con el rating más alto jamás emitida en Nickelodeon, y la propiedad más distribuida de ViacomCBS Domestic Media Networks. ", postPhoto: "spongeBob")
        cell.config(newsPost: newsPost)
        return cell
    }

    
    
}
