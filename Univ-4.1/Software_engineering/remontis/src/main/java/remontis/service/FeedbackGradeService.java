package remontis.service;

import org.springframework.stereotype.Service;
import remontis.domain.FeedbackGrade;
import remontis.domain.User;
import remontis.repos.FeedbackGradeRepo;

import java.util.List;

@Service
public class FeedbackGradeService {

    private final FeedbackGradeRepo feedbackGradeRepo;

    public FeedbackGradeService(FeedbackGradeRepo feedbackGradeRepo) {
        this.feedbackGradeRepo = feedbackGradeRepo;
    }

    public List<FeedbackGrade> findByCompany(User company) {
        return feedbackGradeRepo.findByCompany(company);
    }

    public double countCompanyGrade(List<FeedbackGrade> feedbackGrades) {
        if (feedbackGrades.isEmpty()) {
            return -1;
        }
        return feedbackGrades.stream().mapToInt(FeedbackGrade :: getGrade).average().getAsDouble();
    }

    public FeedbackGrade getByUserAndCompany(User user, User company) {
        return feedbackGradeRepo.findFirstByUserAndCompany(user, company);
    }

    public <S extends FeedbackGrade> S save(S entity) {
        return feedbackGradeRepo.save(entity);
    }
}
