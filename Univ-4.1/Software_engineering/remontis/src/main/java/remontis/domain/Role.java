package remontis.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
  USER, ADMIN, COMPANY;

  @Override
  public String getAuthority() {
    return name();
  }
}
