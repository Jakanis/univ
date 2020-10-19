<#include "security.ftl">
<#import "pager.ftl" as p>
<#import "/spring.ftl" as spring>

<#macro login path isRegisterForm isCompany>

    <form action="${path}" method="post">

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                <@spring.message "Login"/><@spring.message "colon"/>
            </label>
            <div class="col-sm-6">
                <input class="form-control ${(usernameError??)?string('is-invalid', '')}"
                       type="text" name="username" value="<#if user??>${user.username}</#if>"
                       placeholder="<@spring.message "login"/>"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        <@spring.message "${usernameError}"/>
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                <@spring.message "Password"/><@spring.message "colon"/>
            </label>
            <div class="col-sm-6">
                <input class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       type="password" name="password"
                       placeholder="<@spring.message "password"/>"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        <@spring.message "${passwordError}" />
                    </div>
                </#if>
            </div>
        </div>

        <#if isRegisterForm>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    <@spring.message "Password"/><@spring.message "colon"/>
                </label>
                <div class="col-sm-6">
                    <input class="form-control ${(password2Error??)?string('is-invalid', '')}"
                           type="password" name="password2"
                           placeholder=<@spring.message "retype"/>/>
                    <#if password2Error??>
                        <div class="invalid-feedback">
                            <@spring.message "${password2Error}" />
                        </div>
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    <@spring.message "Email"/><@spring.message "colon"/>
                </label>
                <div class="col-sm-6">
                    <input class="form-control ${(emailError??)?string('is-invalid', '')}"
                           type="email" name="email" value="<#if user??>${user.email}</#if>"
                           placeholder="***@***.com"/>
                    <#if emailError??>
                        <div class="invalid-feedback">
                            <@spring.message "${emailError}" />
                        </div>
                    </#if>
                </div>
            </div>
            <#if isCompany>
                <div class="my-3">
                    <@spring.message "Check_your_services"/><@spring.message "colon"/>
                </div>
                <#list services as service>
                    <div class="form-check">
                        <label>
                            <input class="form-check-input" type="checkbox" name="serviceIds" value="${service.id}"/>
                            ${service.name}
                        </label>
                    </div>
                </#list>
            </#if>
        </#if>

        <div class="form-group row">
    <span class="col-sm-3">
      <#if !isRegisterForm>
          <a href="/registration"><@spring.message "add_new_user"/></a>
          <a href="/registration_company"><@spring.message "add_new_company"/></a>
      <#else>
          <a href="/login"><@spring.message "go_to_login_page"/></a>
      </#if>
    </span>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary" type="submit">
                <#if isRegisterForm>
                    <@spring.message "Create"/>
                <#else >
                    <@spring.message "sign_in"/>
                </#if>
            </button>
        </div>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary" type="submit">
            <#if user??>
                <@spring.message "sign_out"/>
            <#else>
                <@spring.message "log_in"/>
            </#if>
        </button>
    </form>
</#macro>