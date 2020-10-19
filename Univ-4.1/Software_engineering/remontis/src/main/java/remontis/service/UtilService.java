package remontis.service;

import org.springframework.stereotype.Service;
import remontis.domain.CompanyService;
import remontis.domain.User;
import remontis.repos.CompanyServiceRepo;

import java.util.Collections;
import java.util.List;

@Service
public class UtilService {

    private final CompanyServiceRepo companyServiceRepo;

    public UtilService(CompanyServiceRepo companyServiceRepo) {
        this.companyServiceRepo = companyServiceRepo;
    }

    List<CompanyService> getCompanyServicesByNameLike(String filter, User company) {
        List<CompanyService> companyServices = companyServiceRepo.findByCompanyId(company.getId());
        List<CompanyService> companyServicesList = new java.util.ArrayList<>(Collections.emptyList());
        for (CompanyService service : companyServices) {
            if (service.getService().getName().contains(filter) || service.getService().getNameUa().contains(filter)) {
                companyServicesList.add(service);
            }
        }
        return  companyServicesList;
    }

}
