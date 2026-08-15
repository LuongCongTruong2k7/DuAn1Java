package whm.service;

import whm.entity.Issue;
import java.util.List;

public interface IssueService {
    List<Issue> findAll();

    Issue findById(Integer id);

    Issue create(String recipient, String remarks, Integer createdByUserId);

    void addDetail(Integer issueId, Integer productId, int quantity);

    void removeDetail(Integer issueId, Integer productId);

    /**
     * @throws IllegalStateException when stock is insufficient or issue
     *                               empty/approved
     */
    void approve(Integer issueId, Integer approvedByUserId);

    void delete(Integer issueId);

    long countPending();
}
