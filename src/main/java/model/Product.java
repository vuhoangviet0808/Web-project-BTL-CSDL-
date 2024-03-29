package model;

public class Product {
    private Supplier supplier;
    private Category category;
    private int id;
    private String title, description, imageURL;
    private int price, compareAtPrice, category_id;

    public Product(int id, String title, int price, int compareAtPrice, String description, String imageURL, int category_id) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.price = price;
        this.compareAtPrice = compareAtPrice;
        this.imageURL = imageURL;
        this.category_id = category_id;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getCompareAtPrice() {
        return compareAtPrice;
    }

    public void setCompareAtPrice(int compareAtPrice) {
        this.compareAtPrice = compareAtPrice;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
}
