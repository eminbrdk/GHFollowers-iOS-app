import Foundation


// optional olmayanları let yaptık
struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String? // nil olabalir ondan optional yaptık
    var location: String? // nil olabalir ondan optional yaptık
    var bio: String? // nil olabalir ondan optional yaptık
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: String
}
