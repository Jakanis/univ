package remontis.controller;

import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import remontis.domain.MyService;
import remontis.domain.Role;
import remontis.domain.User;
import remontis.service.ServiceService;
import remontis.service.UserService;

import java.util.Map;

@Controller
@PreAuthorize("hasAuthority('ADMIN')")
public class AdminController {

  private final UserService userService;
  private final ServiceService serviceService;

  public AdminController(UserService userService, ServiceService serviceService) {
    this.userService = userService;
    this.serviceService = serviceService;
  }

  @GetMapping("/user")
  public String userList(Model model, @PageableDefault(sort = {"id"}) Pageable pageable) {
    model.addAttribute("page", userService.findAll(pageable));
    model.addAttribute("url", "/user");

    return "userList";
  }

  @GetMapping("/user/{user}")
  public String userEditForm(@PathVariable User user, Model model) {
    model.addAttribute("user", user);
    model.addAttribute("roles", Role.values());

    return "userEdit";
  }

  @PostMapping("/user")
  public String userSave(
      @RequestParam Map<String, String> form,
      @RequestParam("userId") User user) {

    userService.userSave(form, user);

    return "redirect:/user";
  }

  @GetMapping("/proveServices")
  public String nonProvedServices(Model model,
                                  @PageableDefault(sort = {"id"}) Pageable pageable) {
    model.addAttribute("page", serviceService.findNonProved(pageable));
    model.addAttribute("url", "/proveServices");
    return "unprovedServices";
  }

  @GetMapping("/proveServices/{myService}")
  public String nonProvedServiceEdit(@PathVariable MyService myService, Model model) {

    model.addAttribute("myService", myService);

    return "unprovedServiceEdit";
  }

  @PostMapping("/proveServices")
  public String nonProveServiceSave(@RequestParam String name, @RequestParam String nameUa,
                                    @RequestParam String description, @RequestParam String descriptionUa,
                                    @RequestParam("myServiceId") MyService myService,
                                    @RequestParam(value = "action") String action) {
    switch (action) {
      case "accept":
        myService.setName(name);
        myService.setNameUa(nameUa);
        myService.setDescription(description);
        myService.setDescriptionUa(descriptionUa);
        myService.setProved(true);
        serviceService.save(myService);
        break;
      case "decline":
        serviceService.delete(myService);
        break;
      default:
        throw new RuntimeException("something wrong with non proved service save");
//        TODO: logger

    }

    return "redirect:/proveServices";
  }

}
