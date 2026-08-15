package whm.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@SuppressWarnings("serial")
@Entity
@Table(name = "ReceiptDetail")
public class ReceiptDetail implements Serializable {
    @EmbeddedId
    private ReceiptDetailId id = new ReceiptDetailId();

    @ManyToOne
    @MapsId("receiptId")
    @JoinColumn(name = "ReceiptID")
    private Receipt receipt;

    @ManyToOne
    @MapsId("productId")
    @JoinColumn(name = "ProductID")
    private Product product;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    public ReceiptDetail(Receipt receipt, Product product, Integer quantity) {
        this.receipt = receipt;
        this.product = product;
        this.quantity = quantity;
        this.id = new ReceiptDetailId(receipt.getReceiptId(), product.getProductId());
    }

    public ReceiptDetail() {
    }

    public ReceiptDetailId getId() {
        return id;
    }

    public void setId(ReceiptDetailId id) {
        this.id = id;
    }

    public Receipt getReceipt() {
        return receipt;
    }

    public void setReceipt(Receipt receipt) {
        this.receipt = receipt;
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
