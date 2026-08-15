package whm.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import java.io.Serializable;

@SuppressWarnings("serial")
@Embeddable
public class ReceiptDetailId implements Serializable {
    @Column(name = "ReceiptID")
    private Integer receiptId;

    @Column(name = "ProductID")
    private Integer productId;

    public ReceiptDetailId() {
    }

    public ReceiptDetailId(Integer receiptId, Integer productId) {
        this.receiptId = receiptId;
        this.productId = productId;
    }

    public Integer getReceiptId() {
        return receiptId;
    }

    public void setReceiptId(Integer receiptId) {
        this.receiptId = receiptId;
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
        if (!(o instanceof ReceiptDetailId other))
            return false;
        return java.util.Objects.equals(receiptId, other.receiptId)
                && java.util.Objects.equals(productId, other.productId);
    }

    @Override
    public int hashCode() {
        return java.util.Objects.hash(receiptId, productId);
    }
}
