package whm.report;

public class FlowReport {
    private Integer productId;
    private String productName;
    private String unit;
    private long received;
    private long issued;

    public long getNet() {
        return received - issued;
    }

    public FlowReport() {
    }

    public FlowReport(Integer productId, String productName, String unit, long received, long issued) {
        this.productId = productId;
        this.productName = productName;
        this.unit = unit;
        this.received = received;
        this.issued = issued;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public long getReceived() {
        return received;
    }

    public void setReceived(long received) {
        this.received = received;
    }

    public long getIssued() {
        return issued;
    }

    public void setIssued(long issued) {
        this.issued = issued;
    }
}
