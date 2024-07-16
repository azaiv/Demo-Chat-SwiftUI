import Foundation

struct ChatModel: Hashable {
    let id = UUID()
    let author: String
    let textMessage: String
    let date: Date
}
