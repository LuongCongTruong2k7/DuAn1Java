package whm.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;

@SuppressWarnings("serial")
@Embeddable
public class IssueDetailId implements Serializable {
    @Column(name = "IssueID")
    private Integer issueId;

    @Column(name = "ProductID")
    private Integer productId;

    public IssueDetailId() {
    }

    public IssueDetailId(Integer issueId, Integer productId) {
        this.issueId = issueId;
        this.productId = productId;
    }

    public Integer getIssueId() {
        return issueId;
    }

    public void setIssueId(Integer issueId) {
        this.issueId = issueId;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (!(o instanceof IssueDetailId other))
            return false;
        return java.util.Objects.equals(issueId, other.issueId) && java.util.Objects.equals(productId, other.productId);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(issueId, productId);
    }
}
