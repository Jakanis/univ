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
import remontis.domain.CompanyService;
import remontis.domain.MyService;
import remontis.domain.User;
import remontis.exception.UserNotFoundException;
import remontis.service.CompanyServiceService;
import remontis.service.ServiceService;
import remontis.service.UserService;

@Controller
@PreAuthorize("hasAuthority('COMPANY')")
public class CompanyController {

    private final CompanyServiceService companySS;
    private final UserService userService;
    private final ServiceService serviceService;

    public CompanyController(CompanyServiceService companySS, UserService userService, ServiceService serviceService) {
        this.companySS = companySS;
        this.userService = userService;
        this.serviceService = serviceService;
    }

    @GetMapping("/add_new_service")
    public String addNewServiceList(@AuthenticationPrincipal UserDetails companyDetails,
                                    @RequestParam(required = false, defaultValue = "") String filter,
                                    Model model, @PageableDefault(sort = {"id"}) Pageable pageable) {
//        TODO: try-catch as in UserController.updateProfile
        User company = userService.findByUsername(companyDetails.getUsername());

        Page<MyService> services;

        if (filter != null && !filter.isEmpty()) {
            services = companySS.getNotCompanyServicesByNameContaining(filter, company, pageable);
        } else {
            services = companySS.getNotCompanyServices(company, pageable);
        }

        model.addAttribute("company", company);
        model.addAttribute("page", services);
        model.addAttribute("filter", filter);
        model.addAttribute("url", "/add_new_service");

        return "addNewCompanyServiceList";
    }

    @GetMapping("/add_new_service/{service}")
    public String addNewService(@PathVariable MyService service, Model model) {
        model.addAttribute("service", service);
        return "addNewCompanyService";
    }


    @PostMapping("/add_new_service/{serviceId}")
    public String addNewServiceConfirm(@AuthenticationPrincipal UserDetails companyDetails,
                                       @PathVariable Long serviceId,
                                       @RequestParam Integer price,
                                       @RequestParam(defaultValue = "false") boolean negotiated) {
        MyService service = serviceService.getOne(serviceId);
        try {
            User company = userService.findByUsername(companyDetails.getUsername());
            CompanyService companyService = CompanyService.builder().company(company).service(service).price(price).negotiated(negotiated).build();
            companySS.save(companyService);
        } catch (UserNotFoundException e) {
//      TODO: log
        }

        return "redirect:/add_new_service";
    }

    @GetMapping("/propose_new_service")
    public String proposeNewService() {
        return "proposeNewService";
    }

    @PostMapping("/propose_new_service")
    public String proposeNewService(@RequestParam String name, @RequestParam String nameUa,
                                    @RequestParam String description, @RequestParam String descriptionUa) {
        MyService service = MyService.builder()
                .name(name)
                .nameUa(nameUa)
                .description(description)
                .descriptionUa(descriptionUa)
                .proved(false)
                .build();
        serviceService.save(service);
        return "proposeNewService";
    }

}
