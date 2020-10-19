<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<#import "/spring.ftl" as spring/>

<@c.page>
  <div class="mb-1">
    <@spring.message "add_new_user"/>
  </div>

  <#if message??>
    <div class="my-3 alert alert-danger" role="alert">
      <@spring.message "${message}"/>
    </div>
  </#if>

  <@l.login "/registration" true false></@l.login>
</@c.page>