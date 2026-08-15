package whm.dao;

import whm.report.FlowReport;
import whm.report.StockReport;
import java.util.Date;
import java.util.List;

public interface ReportDAO {
    /** Current stock of every product (approved receipts minus approved issues). */
    List<StockReport> stock();
    /** Received / issued quantity per product within a date range. */
    List<FlowReport> flow(Date from, Date to);
}
