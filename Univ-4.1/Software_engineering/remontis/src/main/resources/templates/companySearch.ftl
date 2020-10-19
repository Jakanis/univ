<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <div class="form-row mb-4">
        <div class="form-group col-md-6">
            <form class="form-inline" method="get" action=${url}>
                <input class="form-control" type="text" name="filter" value="${filter!''}"
                       placeholder="search"/>
                <button class="btn btn-primary ml-2" type="submit">
                    <@spring.message "Search_by_name_or_service_name"/>
                </button>
            </form>
        </div>
    </div>

    <div class="card-columns">
        <#list companies.content as company>
            <div class="card my-3">
                <h3>${company.username}</h3><br>
                <a class="btn btn-primary" href="/company/${company.id}">
                    <@spring.message "Go_to_company_page"/>
                </a>
            </div>
        <#else>
            <@spring.message "No_companies_for_this_request"/>
        </#list>
    </div>

    <@p.pager url companies />

</@c.page>