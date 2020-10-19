<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <h3 class="my-4"><@spring.message "Services_not_in_our_company"/>:</h3>

    <div class="form-row">
        <div class="form-group col-md-6">
            <form class="form-inline" method="get" action=${url}>
                <input class="form-control" type="text" name="filter" value="${filter!''}"
                       placeholder="search"/>
                <button class="btn btn-primary ml-2" type="submit"><@spring.message "Search"/></button>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list page.content as service>
            <div class="card my-3">
                <#if .locale?starts_with("en")>
                    <span>${service.name}</span><br>
                    <span>${service.description}</span><br>
                <#else >
                    <span>${service.nameUa}</span><br>
                    <span>${service.descriptionUa}</span><br>
                </#if>
                <a class="btn btn-primary" href="/add_new_service/${service.id}"><@spring.message "Add"/></a>
            </div>
        <#else>
            <@spring.message "No_services_available_now"/>
        </#list>
    </div>

    <@p.pager url page />



</@c.page>