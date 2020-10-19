<#include "security.ftl">
<#import "login.ftl" as l>
<#import "/spring.ftl" as spring/>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="/">RegForm</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
            aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/"><@spring.message "home" /></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/company_search"><@spring.message "Search_company" /></a>
            </li>
            <#if user??>
                <li class="nav-item">
                    <a class="nav-link" href="/user/profile"><@spring.message "user_profile" /></a>
                </li>
                <#if isAdmin>
                    <li class="nav-item">
                        <a class="nav-link" href="/user"><@spring.message "user_list" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/proveServices"><@spring.message "list_of_unproved_services" /></a>
                    </li>
                <#else >
                    <li class="nav-item">
                        <a class="nav-link" href="/undone_orders"><@spring.message "Open_orders" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/done_orders"><@spring.message "Closed_orders" /></a>
                    </li>
                </#if>
                <#if isCompany>
                    <li class="nav-item">
                        <a class="nav-link" href="/add_new_service"><@spring.message "Add_new_service" /></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/propose_new_service"><@spring.message "Propose_new_service" /></a>
                    </li>
                </#if>
            </#if>
        </ul>

        <div class="navbar-text mr-3">

            <#function changeLang language>
                <#assign parameters = "?"
                wereLang = false >
                <#list RequestParameters as key, value>
                    ${key} - ${value}
                    <#if key == "lang">
                        <#assign wereLang = true
                        parameters = parameters + "lang=" + language + "&">
                    <#else>
                        <#assign parameters = parameters + key + "=" + value + "&">
                    </#if>
                </#list>
                <#if wereLang == false>
                    <#assign parameters = parameters + "lang=" + language>
                </#if>
                <#return parameters>
            </#function>

            <#list ["ua", "en"] as language>
                <a style="color: magenta;"
                   href="${springMacroRequestContext.requestUri}${changeLang(language)}">
                    <@spring.message "lang_${language}"/>
                </a>
            </#list>

            <#if user??>
                ${name}
            <#else >
                <@spring.message "guest"/>
            </#if>
        </div>
        <@l.logout></@l.logout>
    </div>
</nav>
