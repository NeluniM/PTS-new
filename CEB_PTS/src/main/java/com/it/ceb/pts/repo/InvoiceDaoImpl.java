package com.it.ceb.pts.repo;

import com.it.ceb.pts.domain.*;
import com.it.ceb.util.common.exceptions.ConfigException;
import com.it.ceb.pts.model.ProvinceEnergySummaryModel;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Repository
public class InvoiceDaoImpl implements InvoiceDao {

    @PersistenceContext
    private EntityManager entityManager;

    private List<ProvinceEnergySummaryModel> provinceEnergySummaryList = new ArrayList<>();


    @Transactional
    @Override
    public List<TxnMaster> getTxnList() {
        TypedQuery<TxnMaster> query = entityManager.createQuery(
                "SELECT t FROM TxnMaster t ",
                TxnMaster.class);
        return query.getResultList();
    }

    @Transactional
    @Override
    public List<InvoiceTxn> getInvoiceTxnList(Long billCycleNo, String licenseCode) {
        TypedQuery<InvoiceTxn> query = entityManager.createQuery(
                "SELECT i FROM InvoiceTxn i WHERE i.billCycleNo = :billCycleNo AND i.licenseCode = :licenseCode",
                InvoiceTxn.class);
        query.setParameter("billCycleNo", billCycleNo);
        query.setParameter("licenseCode", licenseCode);
        return query.getResultList();
    }

    @Transactional
    @Override
    public void addInvoiceTxn(InvoiceTxn invoiceTxn) {
        System.out.println("Adding to invoice transactions" );
            entityManager.persist(invoiceTxn);
        System.out.println("Invoice transactions added successfully");
    }

    @Override
    public void updateInvoiceTxn(InvoiceTxn invoiceTxn) {
        InvoiceTxn existingInvoiceTxn = entityManager.find(InvoiceTxn.class, invoiceTxn.getTxnId());
        if (existingInvoiceTxn != null) {
            existingInvoiceTxn.setBillCycleNo(invoiceTxn.getBillCycleNo());
            existingInvoiceTxn.setLicenseCode(invoiceTxn.getLicenseCode());
            existingInvoiceTxn.setCharge(invoiceTxn.getCharge());
            existingInvoiceTxn.setDescription(invoiceTxn.getDescription());
            existingInvoiceTxn.setCreatedBy(invoiceTxn.getCreatedBy());
            existingInvoiceTxn.setCreatedDate(invoiceTxn.getCreatedDate());
            entityManager.merge(existingInvoiceTxn);
        } else {
            System.out.println("Invoice transaction not found for update");
        }
    }

    @Transactional
    @Override
    public void deleteInvoiceTxn(Long txnId) {
        entityManager.createQuery(
                        "DELETE FROM InvoiceTxn i WHERE i.txnId = :txnId")
                .setParameter("txnId", txnId)
                .executeUpdate();
        System.out.println("Invoice transaction deleted successfully");
    }


    @Override
    public void prepareProvinceSummary(Long billCycle, String division) {

        this.provinceEnergySummaryList = new ArrayList<>();

        TypedQuery<Province> query = entityManager.createQuery(
                "SELECT p FROM Province p WHERE p.licenseCode = :licenseCode AND p.status = 1",
                Province.class);
        query.setParameter("licenseCode", division);

        List<Province> provinces = query.getResultList();

        for (Province province : provinces) {
            ProvinceEnergySummaryModel model = new ProvinceEnergySummaryModel();
            model.setProvinceCode(province.getProvinceCode());
            model.setProvinceName(province.getProvinceName());
            this.provinceEnergySummaryList.add(model);
        }

        //fetching all province energy summaries for the given bill cycle and division
        List<ProvinceEnergySummary> provEnSum = entityManager.createQuery(
                        "SELECT p FROM ProvinceEnergySummary p WHERE p.billCycleNo = :billCycle AND p.licenseCode = :division",
                        ProvinceEnergySummary.class)
                .setParameter("billCycle", billCycle)
                .setParameter("division", division)
                .getResultList();

        //matching the details into the provinceEnergySummaryList's relavant province by the provinceCOode
        for (ProvinceEnergySummary summary : provEnSum) {
            for (ProvinceEnergySummaryModel model : this.provinceEnergySummaryList) {
                if (model.getProvinceCode().equals(summary.getProvinceCode())) {
                    model.setDayEnergy(summary.getDayEnergy());
                    model.setPeakEnergy(summary.getPeakEnergy());
                    model.setOffPeakEnergy(summary.getOffPeakEnergy());
                    model.setCoincidentPeak(summary.getCoincidentPeak());
                    model.setDayEnergyAdj(summary.getDayEnergyAdj());
                    model.setPeakEnergyAdj(summary.getPeakEnergyAdj());
                    model.setOffPeakEnergyAdj(summary.getOffPeakEnergyAdj());
                    model.setCoincidentPeakAdj(summary.getCoincidentPeakAdj());
                }
            }
        }
    }

    @Override
    public Boolean isProvinceSummaryCompleted(Long billCycle, String division) {
        System.out.println("Checking if province summary is completed");
        prepareProvinceSummary(billCycle, division);
        if (this.provinceEnergySummaryList.isEmpty()) {
            return false;
        }
        for (ProvinceEnergySummaryModel model : this.provinceEnergySummaryList) {
            if (model.getDayEnergy() == null || model.getPeakEnergy() == null ||
                model.getOffPeakEnergy() == null || model.getCoincidentPeak() == null) {
                return false;
            }
        }
        return true; // All summaries are complete
    }

    @Override
    public Invoice checkInvoice(Long billCycleNo, String licenseCode) {
        try{
            TypedQuery<Invoice> query = entityManager.createQuery(
                    "SELECT i FROM Invoice i WHERE i.id.billCycleNo = :billCycleNo AND i.id.licenseCode = :licenseCode",
                    Invoice.class);
            query.setParameter("billCycleNo", billCycleNo);
            query.setParameter("licenseCode", licenseCode);

            return query.getSingleResult();
        }catch (Exception e){
            System.out.println("Error checking invoice: " + e.getMessage());
            return null;
        }
    }

    @Override
    public Invoice prepareInvoice(Long BillCycleNo, String licenseCode) throws ConfigException {

        // Fetch all matching records from ProvinceEnergySummary
        TypedQuery<ProvinceEnergySummary> query = entityManager.createQuery(
                "SELECT p FROM ProvinceEnergySummary p WHERE p.billCycleNo = :billCycleNo AND p.licenseCode = :licenseCode",
                ProvinceEnergySummary.class);
        query.setParameter("billCycleNo", BillCycleNo);
        query.setParameter("licenseCode", licenseCode);
        TypedQuery<InvoiceTxn> query2 = entityManager.createQuery(
            "SELECT i FROM InvoiceTxn i WHERE i.billCycleNo = :billCycleNo AND i.licenseCode = :licenseCode",
            InvoiceTxn.class);
        query2.setParameter("billCycleNo", BillCycleNo);
        query2.setParameter("licenseCode", licenseCode);
        List<ProvinceEnergySummary> provinceSummaries = query.getResultList();
        List<InvoiceTxn> invoiceTxnList = query2.getResultList(); // all invoice transactions (for late calcs)
        System.out.println("All province summaries fetched");

        // Initialize totals
        BigDecimal DayEnergy = BigDecimal.ZERO;
        BigDecimal OffPeakEnergy = BigDecimal.ZERO;
        BigDecimal CoincidentPeak = BigDecimal.ZERO;
        BigDecimal PeakEnergy = BigDecimal.ZERO;

        // Sum up the values
        for (ProvinceEnergySummary summary : provinceSummaries) {
            DayEnergy = DayEnergy.add(summary.getDayEnergyAdj());
            OffPeakEnergy = OffPeakEnergy.add(summary.getOffPeakEnergyAdj());
            CoincidentPeak = CoincidentPeak.add(summary.getCoincidentPeakAdj());
            PeakEnergy = PeakEnergy.add(summary.getPeakEnergyAdj());
        }
        System.out.println("Total energies for all province summaries calculated");

        //getting the tariff values from tariff table
        System.out.println("Fetching tariffs for license code: " + licenseCode);
        List<Tariff> tariffs = getTariffs(licenseCode);

        if(tariffs == null || tariffs.isEmpty()) {
            System.out.println("Empty tariff set for license code: " + licenseCode);
            throw new ConfigException("No tariff set for bill calculation");
        }
        if (!tariffs.stream().map(t -> t.getTariffCategoryCode().getTariffCategoryCode())
                .collect(Collectors.toSet())
                .containsAll(Set.of("DAY_TRF", "OFFP_TRF", "PEAK_TRF", "CAP_TRF"))) {
            System.out.println("Missing required tariff categories for license code: " + licenseCode);
            throw new ConfigException("All the tariff is not set for bill calculation");
        }

        // Create and return the EnergySummary object
        Invoice invoice = new Invoice();
        InvoiceId invoiceId = new InvoiceId();
        invoiceId.setBillCycleNo(BillCycleNo);
        invoiceId.setLicenseCode(licenseCode);
        invoice.setId(invoiceId);
        invoice.setDayEnergy(DayEnergy);
        invoice.setPeakEnergy(PeakEnergy);
        invoice.setOffPeakEnergy(OffPeakEnergy);
        invoice.setCoincidentPeak(CoincidentPeak);
        for (Tariff tariff : tariffs) {
            if (tariff.getTariffCategoryCode().getTariffCategoryCode().equals("DAY_TRF")){
                invoice.setDayEnergyCharge(tariff.getRate().multiply(DayEnergy));
                invoice.setDayTariff(tariff.getRate());
            }else if(tariff.getTariffCategoryCode().getTariffCategoryCode().equals("OFFP_TRF")){
                invoice.setOffPeakEnergyCharge(tariff.getRate().multiply(OffPeakEnergy));
                invoice.setOffPeakTariff(tariff.getRate());
            } else if (tariff.getTariffCategoryCode().getTariffCategoryCode().equals("PEAK_TRF")) {
                invoice.setPeakEnergyCharge(tariff.getRate().multiply(PeakEnergy));
                invoice.setPeakTariff(tariff.getRate());
            }else if (tariff.getTariffCategoryCode().getTariffCategoryCode().equals("CAP_TRF")) {
                invoice.setCapacityCharge(tariff.getRate().add(CoincidentPeak));
                invoice.setCapacityTariff(tariff.getRate());
            }
        }
        System.out.println("Tariff charges calculated");
        invoice.setTotalEnergy(DayEnergy.add(OffPeakEnergy).add(PeakEnergy));
        invoice.setTotalEnergyCharge(
                invoice.getDayEnergyCharge().add(invoice.getOffPeakEnergyCharge()).add(invoice.getPeakEnergyCharge())
        );
        invoice.setMonthlyTotalCharge(invoice.getTotalEnergyCharge().add(invoice.getCapacityCharge()));

        //adding all invoice transactions to set the totalInvoiceCharge
        invoice.setTotalInvoiceCharge(invoice.getMonthlyTotalCharge());
        if(invoiceTxnList != null) {
            for (InvoiceTxn invoiceTxn : invoiceTxnList) {
              invoice.setTotalInvoiceCharge(invoice.getTotalInvoiceCharge().add(invoiceTxn.getCharge()));
            }
        }
        invoice.setInvoiceCreatedDate(new Date());
        invoice.setIsCalcClosed(0L);
        System.out.println("Invoice prepared");
        return invoice;
    }


    private List<Tariff> getTariffs(String licenseCode) {
        TypedQuery<Tariff> query = entityManager.createQuery(
                "SELECT t FROM Tariff t WHERE " +
                        " t.licenseCode.licenseCode = :licenseCode" +
                        " AND t.isCurrent = 1",
                Tariff.class);
        query.setParameter("licenseCode", licenseCode);
        return query.getResultList();
    }

    @Transactional
    @Override
    public void saveInvoice(Invoice invoice) {
        try {
            InvoiceId invoiceId = new InvoiceId();
            invoiceId.setLicenseCode(invoice.getId().getLicenseCode());
            invoiceId.setBillCycleNo(invoice.getId().getBillCycleNo());

            Invoice existingInvoice = entityManager.find(Invoice.class, invoiceId);

            if (existingInvoice != null) {
                //all properties of the existing invoice will be overwritten
                existingInvoice.setDayEnergy(invoice.getDayEnergy());
                existingInvoice.setPeakEnergy(invoice.getPeakEnergy());
                existingInvoice.setOffPeakEnergy(invoice.getOffPeakEnergy());
                existingInvoice.setCoincidentPeak(invoice.getCoincidentPeak());
                existingInvoice.setDayEnergyCharge(invoice.getDayEnergyCharge());
                existingInvoice.setPeakEnergyCharge(invoice.getPeakEnergyCharge());
                existingInvoice.setOffPeakEnergyCharge(invoice.getOffPeakEnergyCharge());
                existingInvoice.setCapacityCharge(invoice.getCapacityCharge());
                existingInvoice.setTotalEnergy(invoice.getTotalEnergy());
                existingInvoice.setTotalEnergyCharge(invoice.getTotalEnergyCharge());
                existingInvoice.setMonthlyTotalCharge(invoice.getMonthlyTotalCharge());
                existingInvoice.setTotalInvoiceCharge(invoice.getTotalInvoiceCharge());
                existingInvoice.setInvoiceCreatedDate(invoice.getInvoiceCreatedDate());
                existingInvoice.setDayTariff(invoice.getDayTariff());
                existingInvoice.setPeakTariff(invoice.getPeakTariff());
                existingInvoice.setOffPeakTariff(invoice.getOffPeakTariff());
                existingInvoice.setCapacityTariff(invoice.getCapacityTariff());
                existingInvoice.setInvoiceCreatedBy(invoice.getInvoiceCreatedBy());
                existingInvoice.setIsCalcClosed(0L);

                entityManager.merge(existingInvoice);
                System.out.println("Invoice overwritten");
            } else {
                entityManager.persist(invoice);
                System.out.println("New invoice saved");
            }
        } catch (Exception e) {
            System.out.println("Error while saving invoice: " + e.getMessage());
            //e.printStackTrace();//
        }
    }

    @Transactional
    @Override
    public void finalizeBill(Long billCycleNo, String licenseCode) {
        //retrive the invoice by billCycleNo and licenseCode
        TypedQuery<Invoice> query = entityManager.createQuery(
                "SELECT i FROM Invoice i WHERE i.id.billCycleNo = :billCycleNo AND i.id.licenseCode = :licenseCode",
                Invoice.class);
        query.setParameter("billCycleNo", billCycleNo);
        query.setParameter("licenseCode", licenseCode);
        Invoice invoice = query.getSingleResult();
        invoice.setIsCalcClosed(1L);
        entityManager.merge(invoice);
    }


    //=========================================================================
    //             General ops.
    //=========================================================================

    @Override
    public List<ProvinceEnergySummaryModel> getProvinceEnergySummaryList() {
        return this.provinceEnergySummaryList;
    }

}