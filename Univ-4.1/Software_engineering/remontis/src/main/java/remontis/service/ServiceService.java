package remontis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import remontis.domain.MyService;
import remontis.repos.ServiceRepo;

import java.util.List;

@Service
public class ServiceService {

    private final ServiceRepo serviceRepo;

    @Autowired
    public ServiceService(ServiceRepo serviceRepo) {
        this.serviceRepo = serviceRepo;
    }

    public List<MyService> findAll() {
        return serviceRepo.findAll();
    }

    public MyService getOne(Long aLong) {
        return serviceRepo.getOne(aLong);
    }

    public Page<MyService> findNonProved(Pageable pageable) {
        return serviceRepo.findByProved(false, pageable);
    }

    public void delete(MyService myService) {
        serviceRepo.delete(myService);
    }

    public void save(MyService myService) {
        serviceRepo.save(myService);
    }
}
