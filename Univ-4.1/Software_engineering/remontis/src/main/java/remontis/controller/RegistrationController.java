package remontis.controller;

import java.util.Collections;
import java.util.Map;

import remontis.domain.Role;
import remontis.domain.User;
import remontis.exception.UserNotFoundException;
import remontis.service.ServiceService;
import remontis.service.UserService;
import remontis.util.TextConstants;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
public class RegistrationController {

  private final UserService userService;

  private final ServiceService serviceService;

  private RestTemplate restTemplate;

  @Autowired
  public RegistrationController(UserService userService, ServiceService serviceService) {
    this.userService = userService;
    this.serviceService = serviceService;
  }

  @Autowired
  public void setRestTemplate(RestTemplate restTemplate) {
    this.restTemplate = restTemplate;
  }

  @GetMapping("/registration")
  public String registration() {
    return "registration";
  }

  @PostMapping("/registration")
  public String addUser(@RequestParam("password2") String passwordConfirm,
      @Valid User user, BindingResult bindingResult, Model model) {

    boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);

    if (isConfirmEmpty) {
      model.addAttribute("password2Error", TextConstants.PASSWORD2_ERROR);
    }

    boolean isConfirm = true;
    if (user.getPassword() != null && !user.getPassword().equals(passwordConfirm)) {
      model.addAttribute("passwordError", TextConstants.PASSWORDS_ARE_DIFFERENT);
      isConfirm = false;
    }

    if (isConfirmEmpty || bindingResult.hasErrors() || !isConfirm) {
      Map<String, String> errorsMap = UtilController.getErrorMap(bindingResult);

      model.mergeAttributes(errorsMap);

      return "registration";
    }

    if (!userService.addUser(user)) {
      model.addAttribute("message", TextConstants.USER_EXIST);

      return "registration";
    }

    return "redirect:/login";
  }

  @GetMapping("/registration_company")
  public String registrationCompany(Model model) {
    model.addAttribute("services", serviceService.findAll());

    return "registrationCompany";
  }

  @PostMapping("/registration_company")
  public String registerCompany(@RequestParam("password2") String passwordConfirm,
                                @Valid User user, @RequestParam(required = false) long[] serviceIds, BindingResult bindingResult, Model model) {

    boolean isConfirmEmpty = StringUtils.isEmpty(passwordConfirm);

    if (isConfirmEmpty) {
      model.addAttribute("password2Error", TextConstants.PASSWORD2_ERROR);
    }

    boolean isConfirm = true;
    if (user.getPassword() != null && !user.getPassword().equals(passwordConfirm)) {
      model.addAttribute("passwordError", TextConstants.PASSWORDS_ARE_DIFFERENT);
      isConfirm = false;
    }

    if (isConfirmEmpty || bindingResult.hasErrors() || !isConfirm) {
      Map<String, String> errorsMap = UtilController.getErrorMap(bindingResult);

      model.mergeAttributes(errorsMap);

      return "registrationCompany";
    }

    user.setRoles(Collections.singleton(Role.COMPANY));

    if (!userService.addUser(user)) {
      model.addAttribute("message", TextConstants.USER_EXIST);

      return "registrationCompany";
    }

    return "redirect:/login";
  }


  @GetMapping("/activate/{code}")
  public String activate(Model model, @PathVariable String code) {
    try {
      userService.activateUser(code);
      model.addAttribute("messageType", "success");
      model.addAttribute("message", TextConstants.USER_ACTIVATED);
    } catch (UserNotFoundException e) {
      model.addAttribute("messageType", "danger");
      model.addAttribute("message", TextConstants.ACTIVATION_NOT_FOUND);
    }

    return "login";
  }

}
