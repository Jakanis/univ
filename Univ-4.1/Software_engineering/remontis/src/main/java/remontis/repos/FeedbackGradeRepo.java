package remontis.repos;

import org.springframework.data.jpa.repository.JpaRepository;
import remontis.domain.FeedbackGrade;
import remontis.domain.User;

import java.util.List;

public interface FeedbackGradeRepo extends JpaRepository<FeedbackGrade, Long> {

    List<FeedbackGrade> findByCompany(User company);

    FeedbackGrade findFirstByUserAndCompany(User user, User company);
}
