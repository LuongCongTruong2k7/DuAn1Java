package whm.report;

public class StockReport {
    private Integer productId;
    private String productName;
    private String unit;
    private Integer minStock;
    private Integer maxStock;
    private long received;
    private long issued;

    public StockReport(Integer productId, String productName, String unit,
            Integer minStock, Integer maxStock) {
        this.productId = productId;
        this.productName = productName;
        this.unit = unit;
        this.minStock = minStock == null ? 0 : minStock;
        this.maxStock = maxStock == null ? 0 : maxStock;
    }

    public long getStock() {
        return received - issued;
    }

    public boolean isLow() {
        return getStock() < minStock;
    }

    public boolean isOver() {
        return maxStock > 0 && getStock() > maxStock;
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

    public Integer getMinStock() {
        return minStock;
    }

    public void setMinStock(Integer minStock) {
        this.minStock = minStock;
    }

    public Integer getMaxStock() {
        return maxStock;
    }

    public void setMaxStock(Integer maxStock) {
        this.maxStock = maxStock;
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
