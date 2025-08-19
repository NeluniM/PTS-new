package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.Invoice;
import com.it.ceb.pts.domain.InvoiceTxn;
import com.it.ceb.pts.domain.TxnMaster;
import com.it.ceb.util.common.exceptions.ConfigException;
import com.it.ceb.pts.model.ProvinceEnergySummaryModel;

import java.util.List;

public interface InvoiceDao {

    //--------------------------------------------------------------------------
    //                        Bill calculate
    //--------------------------------------------------------------------------

    //invoice txn fields
    List<TxnMaster> getTxnList();
    List<InvoiceTxn> getInvoiceTxnList(Long billCycleNo, String licenseCode);
    void addInvoiceTxn(InvoiceTxn invoiceTxn);
    void updateInvoiceTxn(InvoiceTxn invoiceTxn);
    void deleteInvoiceTxn(Long txnId);

    //bill calculate
    void prepareProvinceSummary(Long billCycle, String division);
    List<ProvinceEnergySummaryModel> getProvinceEnergySummaryList();

    Boolean isProvinceSummaryCompleted(Long billCycle, String division);

    //--------------------------------------------------------------------------
    //                         Invoice
    //--------------------------------------------------------------------------

    Invoice checkInvoice(Long billCycleNo, String licenseCode);
    Invoice prepareInvoice(Long BillCycleNo, String licenseCode) throws ConfigException;

    //DB write-----------------------------
    void saveInvoice(Invoice invoice);

    void finalizeBill(Long billCycleNo, String licenseCode);
}