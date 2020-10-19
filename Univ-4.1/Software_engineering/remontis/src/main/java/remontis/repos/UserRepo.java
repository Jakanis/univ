package remontis.repos;

import java.util.List;
import java.util.Optional;

import remontis.domain.Role;
import remontis.domain.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepo extends JpaRepository<User, Long> {

    Page<User> findAll(Pageable pageable);

    Optional<User> findByUsername(String username);

    Optional<User> findByActivationCode(String code);

    Page<User> findByRolesContaining(Role company, Pageable pageable);
    List<User> findByRolesContaining(Role company);

    List<User> findByRolesContainingAndUsernameContaining(Role company, String filter);
}
