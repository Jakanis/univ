package remontis.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import remontis.domain.CompanyService;
import remontis.domain.MyService;
import remontis.domain.User;
import remontis.repos.CompanyServiceRepo;
import remontis.repos.ServiceRepo;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class CompanyServiceService {

    private final CompanyServiceRepo companyServiceRepo;
    private final ServiceRepo serviceRepo;
    private final UtilService utilService;

    public CompanyServiceService(CompanyServiceRepo companyServiceRepo, ServiceRepo serviceRepo, UtilService utilService) {
        this.companyServiceRepo = companyServiceRepo;
        this.serviceRepo = serviceRepo;
        this.utilService = utilService;
    }

    public <S extends CompanyService> S save(S entity) {
        return companyServiceRepo.save(entity);
    }

    public Page<CompanyService> getCompanyServices(User company, Pageable pageable) {
        return companyServiceRepo.findByCompanyId(company.getId(), pageable);
    }


    public Page<CompanyService> getCompanyServicesByNameLike(String filter, User company, Pageable pageable) {
        List<CompanyService> companyServicesList = utilService.getCompanyServicesByNameLike(filter, company);

        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;
        List<CompanyService> list;

        if (companyServicesList.size() < startItem) {
            list = Collections.emptyList();
        } else {
            int toIndex = Math.min(startItem + pageSize, companyServicesList.size());
            list = companyServicesList.subList(startItem, toIndex);
        }

        return new PageImpl<>(list, PageRequest.of(currentPage, pageSize), companyServicesList.size());
    }

    List<Long> getServicesIdsForCompany(User company) {
        List<CompanyService> companyServices = companyServiceRepo.findByCompanyId(company.getId());
        List<Long> companyServicesIds = new ArrayList<>();
        for (CompanyService companyService : companyServices) {
            companyServicesIds.add(companyService.getService().getId());
        }
        return companyServicesIds;
    }

    public Page<MyService> getNotCompanyServices(User company, Pageable pageable) {
        return serviceRepo.findByProvedAndIdNotIn(true, getServicesIdsForCompany(company), pageable);
    }

    public Page<MyService> getNotCompanyServicesByNameContaining(String filter, User company, Pageable pageable) {
        return serviceRepo.findByProvedAndIdNotInAndNameContainingOrProvedAndIdNotInAndNameUaContaining(
                true, getServicesIdsForCompany(company), filter,
                true, getServicesIdsForCompany(company), filter,
                pageable);
    }
}
