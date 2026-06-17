class Book {
    int bookId;
    String title;
    String author;

    Book(int id, String title, String author) {
        this.bookId = id;
        this.title = title;
        this.author = author;
    }
}

public class LibraryManagement {

    static int linearSearch(Book[] books, String title) {

        for (int i = 0; i < books.length; i++) {
            if (books[i].title.equalsIgnoreCase(title))
                return i;
        }
        return -1;
    }

    public static void main(String[] args) {

        Book[] books = {
                new Book(1, "Java", "James"),
                new Book(2, "Python", "Guido"),
                new Book(3, "C++", "Bjarne")
        };

        int index = linearSearch(books, "Python");

        System.out.println("Found at index: " + index);
    }
}