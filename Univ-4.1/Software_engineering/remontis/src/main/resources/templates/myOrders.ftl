<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <div class="card-columns">
        <#list orders as order>
            <div class="card my-3">
                <#if isCompany>
                    <span><i><@spring.message "Customer"/>: </i>${order.user.username}</span><br>
                <#else >
                    <span><i><@spring.message "Executor"/>: </i>${order.companyService.company.username}</span><br>
                </#if>
                <#if .locale?starts_with("en")>
                    <span><i><@spring.message "Service"/>: </i>${order.companyService.service.name}</span><br>
                <#else>
                    <span><i><@spring.message "Service"/>: </i>${order.companyService.service.nameUa}</span><br>
                </#if>
                <span><i><@spring.message "Price"/>: </i>${order.price}</span><br>
                <a class="btn btn-primary mt-2" href="${url}/${order.id}"><@spring.message "Go_to_order"/></a>
            </div>
        <#else>
            <@spring.message "No_orders"/>
        </#list>
    </div>

</@c.page>