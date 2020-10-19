package remontis.controller;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import remontis.domain.CompanyService;
import remontis.domain.User;
import remontis.exception.UserNotFoundException;
import remontis.service.CompanyServiceService;
import remontis.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/user")
public class UserController {

  private final UserService userService;

  private final CompanyServiceService companySS;

  @Autowired
  public UserController(UserService userService, CompanyServiceService companySS) {
    this.userService = userService;
    this.companySS = companySS;
  }

//  TODO: should work on @AuthenticationPrincipal User user
  @GetMapping("profile")
  public String getProfile(Model model, @AuthenticationPrincipal UserDetails userDetails,
                           @PageableDefault(sort = {"id"}) Pageable pageable) {
//    try {
      User user = userService.findByUsername(userDetails.getUsername());

      model.addAttribute("username", user.getUsername());
      if (user.getEmail() != null) {
        model.addAttribute("email", user.getEmail());
      } else {
        model.addAttribute("email", "");
      }
//    } catch (UserNotFoundException e) {
////      TODO: log
//    }

    Page<CompanyService> services = companySS.getCompanyServices(user, pageable);


    model.addAttribute("page", services);

    return "profile";
  }

  //TODO: should work on @AuthenticationPrincipal User user
  //TODO: validation!!
  @PostMapping("profile")
  public String updateProfile(@AuthenticationPrincipal UserDetails userDetails,
      @RequestParam String password, @RequestParam String email) {
    try {
      User user = userService.findByUsername(userDetails.getUsername());
      userService.updateProfile(user, password, email);
    } catch (UserNotFoundException e) {
//      TODO: log
    }
    return "redirect:/user/profile";
  }

}
