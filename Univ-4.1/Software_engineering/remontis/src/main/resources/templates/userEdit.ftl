<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as spring/>

<@c.page>
  <div class="mb-4">
    <h4><@spring.message "user_editor"/></h4>
  </div>

  <form action="/user" method="post">
    <div class="form-group row">
      <label class="col-sm-2 col-form-label"><@spring.message "Username"/></label>
      <div class="col-sm-6">
        <input class="form-control" type="text" value="${user.username}" readonly/>
      </div>
    </div>
    <#list roles as role>
      <div class="form-check">
        <label>
          <#assign checked=user.roles?seq_contains(role)>
          <#if role="USER" || role = "COMPANY"|| (role="ADMIN" && checked)>
            <#assign disable = true>
          <#else>
            <#assign disable = false>
          </#if>
          <input class="form-check-input" type="checkbox" ${disable?string("disabled", "")}
                 name="${role}" ${checked?string("checked", "")} />${role}
        </label>
      </div>
    </#list>

    <input type="hidden" value="${user.id}" name="userId"/>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <button class="btn btn-primary mt-3" type="submit">
      <@spring.message "Save"/>
    </button>
  </form>
</@c.page>