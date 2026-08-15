package whm.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@SuppressWarnings("serial")
@Entity
@Table(name = "Issue")
public class Issue implements Serializable {
    public static final String PENDING = "PENDING";
    public static final String APPROVED = "APPROVED";

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "IssueID")
    private Integer issueId;

    @ManyToOne
    @JoinColumn(name = "CreatedBy", nullable = false)
    private User createdBy;

    @ManyToOne
    @JoinColumn(name = "ApprovedBy")
    private User approvedBy;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "OrderDate")
    private Date orderDate = new Date();

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ApprovalDate")
    private Date approvalDate;

    @Column(name = "Recipient")
    private String recipient;

    @Column(name = "Status")
    private String status = PENDING;

    @Column(name = "Remarks")
    private String remarks;

    @OneToMany(mappedBy = "issue", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<IssueDetail> details = new ArrayList<>();

    public boolean isPending() {
        return PENDING.equals(status);
    }

    public int getTotalQuantity() {
        return details == null ? 0 : details.stream().mapToInt(IssueDetail::getQuantity).sum();
    }

    public Issue() {
    }

    public Integer getIssueId() {
        return issueId;
    }

    public void setIssueId(Integer issueId) {
        this.issueId = issueId;
    }

    public User getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(User createdBy) {
        this.createdBy = createdBy;
    }

    public User getApprovedBy() {
        return approvedBy;
    }

    public void setApprovedBy(User approvedBy) {
        this.approvedBy = approvedBy;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public Date getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(Date approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public List<IssueDetail> getDetails() {
        return details;
    }

    public void setDetails(List<IssueDetail> details) {
        this.details = details;
    }
}
