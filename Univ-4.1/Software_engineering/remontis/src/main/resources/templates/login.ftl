<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>

<@c.page>

  <div class="my-3">
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
      <div class="alert alert-danger" role="alert">
        ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
      </div>
    </#if>
  </div>

  <div class="my-3">
    <#if message??>
      <div class="alert alert-${messageType}" role="alert">
        ${message}
      </div>
    </#if>
  </div>

  <@l.login "/login" false false></@l.login>
</@c.page>