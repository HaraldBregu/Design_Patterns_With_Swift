import UIKit

protocol Visitor {
    func visit(book: Book)
    func visit(movie: Movie)
}

protocol Media {
    func accept(visitor: Visitor)
}

class Book: Media {
    let title: String
    let author: String

    init(title: String, author: String) {
        self.title = title
        self.author = author
    }

    func accept(visitor: Visitor) {
        visitor.visit(book: self)
    }
}

class Movie: Media {
    let title: String
    let director: String

    init(title: String, director: String) {
        self.title = title
        self.director = director
    }

    func accept(visitor: Visitor) {
        visitor.visit(movie: self)
    }
}

class ShortSummaryVisitor: Visitor {
    func visit(book: Book) {
        print("Book: \(book.title) by \(book.author)")
    }

    func visit(movie: Movie) {
        print("Movie: \(movie.title) directed by \(movie.director)")
    }
}

class LongSummaryVisitor: Visitor {
    func visit(book: Book) {
        print("Book: \(book.title) by \(book.author). This is a great book about \(book.title).")
    }

    func visit(movie: Movie) {
        print("Movie: \(movie.title) directed by \(movie.director). This is a great movie about \(movie.title).")
    }
}

let media: [Media] = [
    Book(title: "The Catcher in the Rye", author: "J.D. Salinger"),
    Movie(title: "The Godfather", director: "Francis Ford Coppola")]

let shortSummaryVisitor = ShortSummaryVisitor()
let longSummaryVisitor = LongSummaryVisitor()

media.forEach { item in
    item.accept(visitor: shortSummaryVisitor)
    item.accept(visitor: longSummaryVisitor)
}
