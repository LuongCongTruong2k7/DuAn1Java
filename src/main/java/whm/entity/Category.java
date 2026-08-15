package whm.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@SuppressWarnings("serial")
@Entity @Table(name = "Category")
public class Category implements Serializable {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryID")
    private Integer categoryId;

    @Column(name = "CategoryName", nullable = false)
    private String categoryName;

    @OneToMany(mappedBy = "category")
    private List<Product> products;

    public Category() {}

    public Integer getCategoryId() 
    { 
    	return categoryId; 
    }

    public void setCategoryId(Integer categoryId) 
    {
    	this.categoryId = categoryId; 
    }

    public String getCategoryName() {
        return categoryName; 
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName; 
    }

    public List<Product> getProducts() { 
        return products; 
    }

    public void setProducts(List<Product> products) { 
        this.products = products; 
    }
}
