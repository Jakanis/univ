package remontis.repos;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import remontis.domain.MyService;

import java.util.List;

public interface ServiceRepo extends JpaRepository<MyService, Long> {

    List<MyService> findAll();

    Page<MyService> findByProved(boolean proved, Pageable pageable);

    Page<MyService> findByProvedAndIdNotIn(boolean proved, List<Long> ids, Pageable pageable);

    Page<MyService> findByProvedAndIdNotInAndNameContainingOrProvedAndIdNotInAndNameUaContaining(
            boolean proved1, List<Long> ids1, String name,
            boolean proved2, List<Long> ids2, String nameUa,
            Pageable pageable);

//    @Query("select s from MyService as s join CompanyService as cs where s.name like :name and cs.company = :company")
//    List<MyService> findByCompanyAndNameLike(@Param("name")String filter, @Param("company") User company);
//
//    @Query("select s from MyService as s join CompanyService as cs where cs.company = :company")
//    List<MyService> findByCompany(@Param("company")User company);


}
