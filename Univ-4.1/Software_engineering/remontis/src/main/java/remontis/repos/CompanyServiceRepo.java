package remontis.repos;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import remontis.domain.CompanyService;

import java.util.List;

public interface CompanyServiceRepo extends JpaRepository<CompanyService, Long> {

    Page<CompanyService> findByCompanyId(Long id, Pageable pageable);

    List<CompanyService> findByCompanyId(Long id);

}
