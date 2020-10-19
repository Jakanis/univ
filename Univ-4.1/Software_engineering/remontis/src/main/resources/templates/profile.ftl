<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#import "/spring.ftl" as spring/>
<#include "parts/security.ftl" />

<@c.page>

    <div class="my-3">
        <h1><#if username??>
                ${username}
            <#else >
                <@spring.message "guest"/>
            </#if></h1>
    </div>

    <div class="my-3">
        <#if message??>
            ${message}
        </#if>
    </div>

    <form method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                <@spring.message "Password"/><@spring.message "colon"/>
            </label>
            <div class="col-sm-6">
                <input class="form-control"
                       type="password" name="password"
                       placeholder="<@spring.message "password"/>"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                <@spring.message "Email"/><@spring.message "colon"/>
            </label>
            <div class="col-sm-6">
                <input class="form-control"
                       type="email" name="email"
                       placeholder="***@***.com"
                       value="${email!''}"/>
            </div>
        </div>

        <div class="form-group row">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary ml-3" type="submit">
                <@spring.message "Save"/>
            </button>
        </div>
    </form>




    <#if isCompany>

        <h3 class="my-4"><@spring.message "Our_company_services"/>:</h3>

        <div class="card-columns">
            <#list page.content as companyService>
                <div class="card my-3">
                    <#if .locale?starts_with("en")>
                        <span>${companyService.service.name}</span><br>
                        <span>${companyService.service.description}</span><br>
                    <#else >
                        <span>${companyService.service.nameUa}</span><br>
                        <span>${companyService.service.descriptionUa}</span><br>
                    </#if>
                    <span>price: ${companyService.price}</span><br>
                    <#if companyService.negotiated>
                        <#assign negotiated = 'You_can_talk_about_price'
                        color = 'green'>
                    <#else>
                        <#assign negotiated = 'You_cannot_talk_about_price'
                        color = 'red'>
                    </#if>
                    <span style="color: ${color}"><@spring.message "${negotiated}"/></span><br>
                </div>
            <#else>
                <@spring.message "No_services_available_now"/>
            </#list>
        </div>
    </#if>

</@c.page>