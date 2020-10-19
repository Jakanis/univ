package remontis.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import remontis.util.TextConstants;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;
import java.util.Collection;
import java.util.Set;

//TODO: some file for regexps

@Getter
@Setter
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "usr")
public class User implements UserDetails {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private Long id;

  //TODO: own annotation for this validation
  @Pattern(regexp = "^[A-Za-z0-9_]{6,30}$", message = TextConstants.USERNAME_ERROR)
  private String username;

  @NotBlank(message = TextConstants.FILL_THE_FIELD)
  @Size(max = 255, message = TextConstants.PASSWORD_CANNOT_BE_LONG)
  private String password;

  private boolean active;

  @Email(message = TextConstants.EMAIL_NOT_CORRECT)
  @NotBlank(message = TextConstants.FILL_THE_FIELD)
  @Size(max = 255, message = TextConstants.EMAIL_CANNOT_BE_LONG)
  private String email;

  private String activationCode;

  @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
  @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
  @Enumerated(EnumType.STRING)
  private Set<Role> roles;

  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return getRoles();
  }

  @Override
  public boolean isAccountNonExpired() {
    return false;
  }

  @Override
  public boolean isAccountNonLocked() {
    return true;
  }

  @Override
  public boolean isCredentialsNonExpired() {
    return true;
  }

  @Override
  public boolean isEnabled() {
    return isActive();
  }
}
