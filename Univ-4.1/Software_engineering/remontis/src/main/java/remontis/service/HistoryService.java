package remontis.service;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;
import remontis.domain.History;
import remontis.domain.User;
import remontis.repos.HistoryRepo;

import java.util.ArrayList;
import java.util.List;

@Service
public class HistoryService {
    private final HistoryRepo historyRepo;

    public HistoryService(HistoryRepo historyRepo) {
        this.historyRepo = historyRepo;
    }

    public <S extends History> S save(S entity) {
        return historyRepo.save(entity);
    }

    public List<History> getUserOrdersByDone(User user, boolean done) {
        return historyRepo.findByUserAndDone(user, done);
    }

    public List<History> getCompanyOrdersByDone(User user, boolean done) {
        List<History> orders = historyRepo.findByDone(done);

        List<History> ans = new ArrayList<>();
        for (History order: orders) {
            if (order.getCompanyService().getCompany() == user) {
                ans.add(order);
            }
        }

        return ans;
    }
}
