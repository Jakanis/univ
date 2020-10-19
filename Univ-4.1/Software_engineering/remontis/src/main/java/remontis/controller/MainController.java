package remontis.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import remontis.domain.*;
import remontis.exception.UserNotFoundException;
import remontis.service.*;
import remontis.util.MailTemplating;

import java.util.List;
import java.util.Optional;

@Controller
public class MainController {

    private final CompanyServiceService companySS;
    private final FeedbackGradeService feedbackGradeService;
    private final UserService userService;
    private final HistoryService historyService;
    private final MailSender mailSender;

    public MainController(CompanyServiceService companySS, FeedbackGradeService feedbackGradeService, UserService userService, HistoryService historyService, MailSender mailSender) {
        this.companySS = companySS;
        this.feedbackGradeService = feedbackGradeService;
        this.userService = userService;
        this.historyService = historyService;
        this.mailSender = mailSender;
    }

    @GetMapping("/")
    public String greeting() {
        return "greeting";
    }

    @GetMapping("/company/{company}")
    public String companyPage(@RequestParam(required = false, defaultValue = "") String filter,
                              @PathVariable User company,
                              Model model, @PageableDefault(sort = {"id"}) Pageable servicesPageable) {

        Page<CompanyService> services;

        if (filter != null && !filter.isEmpty()) {
            services = companySS.getCompanyServicesByNameLike(filter, company, servicesPageable);
        } else {
            services = companySS.getCompanyServices(company, servicesPageable);
        }

        model.addAttribute("company", company);
        model.addAttribute("servicesPage", services);
        model.addAttribute("filter", filter);
        model.addAttribute("url", "/company/" + company.getId());

        List<FeedbackGrade> feedbackGrades = feedbackGradeService.findByCompany(company);
        model.addAttribute("grade", feedbackGradeService.countCompanyGrade(feedbackGrades));
        model.addAttribute("feedback", feedbackGrades);

        return "companyPage";
    }

    @PreAuthorize("hasAuthority('USER')")
    @GetMapping("/company/{company}/add_feedback")
    public String companyFeedback(@AuthenticationPrincipal UserDetails userDetails,
                                  @PathVariable User company,
                                  Model model) {

        User user = userService.findByUsername(userDetails.getUsername());

        FeedbackGrade feedbackGrade = feedbackGradeService.getByUserAndCompany(user, company);

        model.addAttribute("feedback", feedbackGrade);
        model.addAttribute("company", company);

        return "addFeedback";
    }

    @PostMapping("/company/{company}/add_feedback")
    public String companyFeedbackConfirm(@AuthenticationPrincipal UserDetails userDetails,
                                         @PathVariable User company,
                                         @RequestParam Byte grade,
                                         @RequestParam String feedback) {

        User user = userService.findByUsername(userDetails.getUsername());

        FeedbackGrade feedbackGrade = Optional.ofNullable(feedbackGradeService.getByUserAndCompany(user, company))
                .orElse(FeedbackGrade.builder().user(user).company(company).build());

        feedbackGrade.setGrade(grade);
        feedbackGrade.setFeedback(feedback);

        feedbackGradeService.save(feedbackGrade);
        return "redirect:/company/{company}";

    }

    @GetMapping("/company_search")
    public String companySearch(@RequestParam(required = false, defaultValue = "") String filter,
                                @PageableDefault(sort = {"id"}) Pageable pageable,
                                Model model) {
        Page<User> companies;

        if (filter != null && !filter.isEmpty()) {
            companies = userService.getCompaniesByNameContainingOrServiceNameContaining(filter, pageable);
        } else {
            companies = userService.getCompanies(pageable);
        }

        model.addAttribute("companies", companies);
        model.addAttribute("filter", filter);
        model.addAttribute("url", "/company_search");

        return "companySearch";
    }

    @PreAuthorize("hasAuthority('USER')")
    @GetMapping("/order_service/{companyService}")
    public String order(@AuthenticationPrincipal UserDetails userDetails,
                        @PathVariable CompanyService companyService,
                        Model model) {

        model.addAttribute("companyService", companyService);

        return "doOrder";
    }

    @PostMapping("/order_service/{companyService}")
    public String orderPost(@AuthenticationPrincipal UserDetails userDetails,
                            @PathVariable CompanyService companyService,
                            @RequestParam String comment) {

        User user = userService.findByUsername(userDetails.getUsername());
        History history = History.builder()
                .user(user)
                .companyService(companyService)
                .price(companyService.getPrice())
                .userComment(comment)
                .companyComment("")
                .build();
        historyService.save(history);

        mailSender.send(companyService.getCompany().getEmail(),
                "New order",
                MailTemplating.TemplateType.NEW_ORDER+history.getId().toString());


        return "redirect:/undone_orders";
    }

    @PreAuthorize("hasAuthority('USER') OR hasAuthority('COMPANY')")
    @GetMapping("/undone_orders")
    public String open_orders(@AuthenticationPrincipal UserDetails userDetails,
                              Model model) {

        try {
            User user = userService.findByUsername(userDetails.getUsername());
            if (user.getRoles().contains(Role.USER)) {
                model.addAttribute("orders", historyService.getUserOrdersByDone(user, false));
            } else {
                model.addAttribute("orders", historyService.getCompanyOrdersByDone(user, false));
            }
        } catch (UserNotFoundException e) {
//      TODO: log
        }

        model.addAttribute("url", "/undone_orders");

        return "myOrders";
    }

    @PreAuthorize("hasAuthority('USER') OR hasAuthority('COMPANY')")
    @GetMapping("/done_orders")
    public String closed_orders(@AuthenticationPrincipal UserDetails userDetails,
                                Model model) {

        try {
            User user = userService.findByUsername(userDetails.getUsername());
            if (user.getRoles().contains(Role.USER)) {
                model.addAttribute("orders", historyService.getUserOrdersByDone(user, true));
            } else {
                model.addAttribute("orders", historyService.getCompanyOrdersByDone(user, true));
            }
        } catch (UserNotFoundException e) {
//      TODO: log
        }

        model.addAttribute("url", "/done_orders");

        return "myOrders";
    }

    @PreAuthorize("hasAuthority('USER') OR hasAuthority('COMPANY')")
    @GetMapping("/undone_orders/{history}")
    public String open_order(@AuthenticationPrincipal UserDetails userDetails,
                             @PathVariable History history,
                             Model model) {

        if (history.isDone()) {
            return "redirect:/undone_orders";
        }

        try {
            User user = userService.findByUsername(userDetails.getUsername());
            if (user.getRoles().contains(Role.USER)) {
                if (user != history.getUser()) {
                    return "redirect:/undone_orders";
                }
            } else {
                if (user != history.getCompanyService().getCompany()) {
                    return "redirect:/undone_orders";
                }
            }
        } catch (UserNotFoundException e) {
//      TODO: log
        }

        model.addAttribute("order", history);
        model.addAttribute("url", "/undone_orders");

        return "order";
    }

    @PostMapping("/undone_orders/{history}")
    public String orderUpdate(@AuthenticationPrincipal UserDetails userDetails,
                                    @PathVariable History history, @RequestParam String comment,
                                    @RequestParam(defaultValue = "false", required = false) boolean orderClosed) {

        String email = "";

        if (userDetails.getAuthorities().contains(Role.USER)) {
            history.setUserComment(comment);
            email = history.getCompanyService().getCompany().getEmail();
        } else if (userDetails.getAuthorities().contains(Role.COMPANY)) {
            history.setCompanyComment(comment);
            email = history.getUser().getEmail();
            if (orderClosed) {
                history.setDone(true);
                mailSender.send(history.getUser().getEmail(),
                        "Done order",
                        MailTemplating.TemplateType.NEW_ORDER+history.getId().toString());
            }
        }
        mailSender.send(email,
                "Order updated",
                MailTemplating.TemplateType.COMMENT+history.getId().toString());

        return "redirect:/undone_orders";
    }

    @PreAuthorize("hasAuthority('USER') OR hasAuthority('COMPANY')")
    @GetMapping("/done_orders/{history}")
    public String closed_order(@AuthenticationPrincipal UserDetails userDetails,
                               @PathVariable History history,
                               Model model) {

        if (!history.isDone()) {
            return "redirect:/undone_orders";
        }

        try {
            User user = userService.findByUsername(userDetails.getUsername());
            if (user.getRoles().contains(Role.USER)) {
                if (user != history.getUser()) {
                    return "redirect:/done_orders";
                }
            } else {
                if (user != history.getCompanyService().getCompany()) {
                    return "redirect:/done_orders";
                }
            }
        } catch (UserNotFoundException e) {
//      TODO: log
        }

        model.addAttribute("order", history);
        model.addAttribute("url", "/done_orders");

        return "order";
    }

}
