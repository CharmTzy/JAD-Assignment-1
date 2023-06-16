package books;

import java.util.ArrayList;

public class Book {
    private String bookId;
    private String title;
    private String author;
    private int inventory;

    public Book(String bookId, String title, String author, int inventory) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.inventory = inventory;
    }

    // Getters and Setters

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }
}
