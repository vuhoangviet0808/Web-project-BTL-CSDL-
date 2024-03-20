package model;

import java.util.Objects;

public class ProductInCart {
    private String title;
    private int price;
    private int quantity;
    private String option;
    private String imageURL;

    public ProductInCart(String title, int price, int quantity, String option, String imageURL) {
        this.title = title;
        this.price = price;
        this.quantity = quantity;
        this.option = option;
        this.imageURL = imageURL;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof ProductInCart)) return false;
        ProductInCart that = (ProductInCart) o;
        return Objects.equals(getTitle(), that.getTitle()) && Objects.equals(getOption(), that.getOption());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getTitle(), getOption());
    }
}
