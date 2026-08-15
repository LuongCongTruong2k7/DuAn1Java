package whm.service;

import whm.report.FlowReport;
import whm.report.StockReport;
import java.util.Date;
import java.util.List;

public interface ReportService {
    List<StockReport> stock();

    List<StockReport> lowStock();

    List<FlowReport> flow(Date from, Date to);
}
