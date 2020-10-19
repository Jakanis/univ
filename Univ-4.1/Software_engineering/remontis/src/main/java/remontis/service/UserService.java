package remontis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import remontis.domain.CompanyService;
import remontis.domain.Role;
import remontis.domain.User;
import remontis.exception.UserNotFoundException;
import remontis.repos.UserRepo;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    private final UserRepo userRepo;
    private final MailSender mailSender;

    private final PasswordEncoder passwordEncoder;
    private final UtilService utilService;

    @Autowired
    public UserService(UserRepo userRepo, MailSender mailSender, PasswordEncoder passwordEncoder, UtilService utilService) {
        this.userRepo = userRepo;
        this.mailSender = mailSender;
        this.passwordEncoder = passwordEncoder;
        this.utilService = utilService;
    }

    @Override
    public UserDetails loadUserByUsername(String s) { //TODO: check if User
        Optional<User> user = userRepo.findByUsername(s);
        return user.orElseThrow(() -> new UsernameNotFoundException("User not exist!"));
    }

//  @Override
//  public User loadUserByUsername(String s) { //TODO: check if User
//    Optional<User> user = userRepo.findByUsername(s);
//    return user.orElseThrow(() -> new UsernameNotFoundException("User not exist!"));
//  }


    public boolean addUser(User user) {
        user.setActive(false);
        user.setRoles(Collections.singleton(Role.USER));
        user.setActivationCode(UUID.randomUUID().toString());
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        try {
            userRepo.save(user);
        } catch (Exception e) {
            return false;
        }

        sendMessage(user);

        return true;
    }

    private void sendMessage(User user) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Hello, %s \n" + "Welcome to Remontis!. Please, visit next link to activate your profile: "
                            + "http://localhost:8090/activate/%s",
                    user.getUsername(),
                    user.getActivationCode()
            );

            mailSender.send(user.getEmail(), "Activation code", message);
        }
    }

    public void userSave(Map<String, String> form, User user) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());

        user.getRoles().clear();
        for (String key : form.keySet()) {
            System.out.println(key);
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
    }

    public Page<User> findAll(Pageable pageable) {
        return userRepo.findAll(pageable);
    }

    public void activateUser(String code) {
        User user = userRepo.findByActivationCode(code)
                .orElseThrow(() -> new UserNotFoundException("User with that code is not found"));

        user.setActivationCode(null);
        user.setActive(true);

        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String userEmail = user.getEmail();

        boolean isEmailChanged = (email != null && !email.equals(userEmail))
                || (userEmail != null && !userEmail.equals(email));

        if (isEmailChanged) {
            user.setEmail(email);

            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
                user.setActive(false);
            }
        }

        if (!StringUtils.isEmpty(password)) {
            user.setPassword(passwordEncoder.encode(password));
        }

        userRepo.save(user);

        if (isEmailChanged) {
            sendMessage(user);
        }
    }

    //TODO: own exception
    public User findByUsername(String username) {
        return userRepo.findByUsername(username)
                .orElseThrow(() -> new UserNotFoundException("User is not found by username"));
    }

    public Page<User> getCompanies(Pageable pageable) {
        return userRepo.findByRolesContaining(Role.COMPANY, pageable);
    }

    public Page<User> getCompaniesByNameContainingOrServiceNameContaining(String filter, Pageable pageable) {
        List<User> companies = userRepo.findByRolesContaining(Role.COMPANY);
        List<User> ans = userRepo.findByRolesContainingAndUsernameContaining(Role.COMPANY, filter);

        for (User company: companies) {
            List<CompanyService> companyServices = utilService.getCompanyServicesByNameLike(filter, company);
            if (!companyServices.isEmpty()) {
                ans.add(company);
            }
        }

        int pageSize = pageable.getPageSize();
        int currentPage = pageable.getPageNumber();
        int startItem = currentPage * pageSize;
        List<User> list;

        if (ans.size() < startItem) {
            list = Collections.emptyList();
        } else {
            int toIndex = Math.min(startItem + pageSize, ans.size());
            list = ans.subList(startItem, toIndex);
        }

        return new PageImpl<>(list, PageRequest.of(currentPage, pageSize), ans.size());
    }
}
