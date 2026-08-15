package whm.service;

import whm.dao.ReportDAO;
import whm.dao.ReportDAOImpl;
import whm.report.FlowReport;
import whm.report.StockReport;
import java.util.Date;
import java.util.List;

public class ReportServiceImpl implements ReportService {
    private final ReportDAO dao = new ReportDAOImpl();

    @Override
    public List<StockReport> stock() {
        return dao.stock();
    }

    @Override
    public List<StockReport> lowStock() {
        return dao.stock().stream().filter(StockReport::isLow).toList();
    }

    @Override
    public List<FlowReport> flow(Date from, Date to) {
        return dao.flow(from, to);
    }
}
