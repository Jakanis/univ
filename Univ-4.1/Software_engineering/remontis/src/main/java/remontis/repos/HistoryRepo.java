package remontis.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import remontis.domain.History;
import remontis.domain.User;

import java.util.List;

public interface HistoryRepo extends JpaRepository<History, Long> {

    List<History> findByUserAndDone(User user, boolean done);

    List<History> findByDone(boolean done);

}
