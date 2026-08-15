package whm.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@SuppressWarnings("serial")
@Entity @Table(name = "IssueDetail")
public class IssueDetail implements Serializable {
    @EmbeddedId
    private IssueDetailId id = new IssueDetailId();

    @ManyToOne @MapsId("issueId")
    @JoinColumn(name = "IssueID")
    private Issue issue;

    @ManyToOne @MapsId("productId")
    @JoinColumn(name = "ProductID")
    private Product product;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    public IssueDetail(Issue issue, Product product, Integer quantity) {
        this.issue = issue;
        this.product = product;
        this.quantity = quantity;
        this.id = new IssueDetailId(issue.getIssueId(), product.getProductId());
    }

    public IssueDetail() {}

    public IssueDetailId getId() { 
        return id; 
    }

    public void setId(IssueDetailId id) { 
        this.id = id; 
    }

    public Issue getIssue() { 
        return issue; 
    }

    public void setIssue(Issue issue) { 
        this.issue = issue; 
    }

    public Product getProduct() { 
        return product; 
    }

    public void setProduct(Product product) { 
        this.product = product; 
    }

    public Integer getQuantity() { 
        return quantity; 
    }

    public void setQuantity(Integer quantity) { 
        this.quantity = quantity; 
    }
}
