<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <h1 class="display-1 my-2">${company.username}</h1>

    <h3 class="my-4"><@spring.message "Our_company_services"/>:</h3>

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
        <#list servicesPage.content as companyService>
            <div class="card my-3">
                <#if .locale?starts_with("en")>
                    <span>${companyService.service.name}</span><br>
                    <span>${companyService.service.description}</span><br>
                <#else >
                    <span>${companyService.service.nameUa}</span><br>
                    <span>${companyService.service.descriptionUa}</span><br>
                </#if>
                <span>price: ${companyService.price}</span><br>
<#--                <#if companyService.negotiated>-->
<#--                    <#assign negotiated = 'you can talk about price'-->
<#--                    color = 'green'>-->
<#--                <#else>-->
<#--                    <#assign negotiated = 'you cannot talk about price'-->
<#--                    color = 'red'>-->
<#--                </#if>-->
<#--                <span style="color: ${color}">${negotiated}</span><br>-->
                <#if companyService.negotiated>
                    <#assign negotiated = 'You_can_talk_about_price'
                    color = 'green'>
                <#else>
                    <#assign negotiated = 'You_cannot_talk_about_price'
                    color = 'red'>
                </#if>
                <span style="color: ${color}"><@spring.message "${negotiated}"/></span><br>
                <#if !isAdmin && !isCompany>
                    <a class="btn btn-primary" href="/order_service/${companyService.id}">
                        <@spring.message "Order"/>
                    </a>
                </#if>
            </div>
        <#else>
            <@spring.message "No_services_available_now"/>
        </#list>
    </div>

    <@p.pager url servicesPage />



    <h3 class="my-4"><@spring.message "Feedback"/></h3>

    <#if grade gt 0>
        <p><@spring.message "Average_grade_for_all_time"/>: <b>${grade}</b></p>
    </#if>

    <#if !isCompany && !isAdmin>
        <a class="btn btn-primary" href="${url}/add_feedback"><@spring.message "Add_feedback"/></a>
    </#if>

    <div class="card-columns">
        <#list feedback as feedback>
            <div class="card my-3">
                <span><i>${feedback.user.username}</i></span><br>
                <span>grade: ${feedback.grade}</span><br>
                <span>${feedback.feedback}</span><br>
            </div>
        <#else>
            <@spring.message "No_feedback"/>
        </#list>
    </div>



</@c.page>