package whm.dao;

import whm.entity.Issue;
import java.util.List;

public interface IssueDAO {
    List<Issue> findAll();
    Issue findById(Integer id);
    Issue create(Issue i);
    Issue update(Issue i);
    void deleteById(Integer id);
    long countByStatus(String status);
}
