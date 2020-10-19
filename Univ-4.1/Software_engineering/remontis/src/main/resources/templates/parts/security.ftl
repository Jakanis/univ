<#assign
known = Session.SPRING_SECURITY_CONTEXT??
>

<#assign
name = "unknown"
isAdmin = false
isCompany = false
>

<#if known>
    <#assign
    user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
    name = user.getUsername()
    authorities = Session.SPRING_SECURITY_CONTEXT.authentication.authorities
    >
    <#list authorities as authority>
        <#if authority = 'ADMIN'>
            <#assign isAdmin = true >
        </#if>
        <#if authority = 'COMPANY'>
            <#assign isCompany = true >
        </#if>
    </#list>
</#if>