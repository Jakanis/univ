<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <form method="post">

        <#if isCompany>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Customer"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.user.username}" readonly/>
                </div>
            </div>
        <#else >
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Executor"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.companyService.company.username}" readonly/>
                </div>
            </div>
        </#if>
        <#if .locale?starts_with("en")>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_name"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.companyService.service.name}" readonly/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_description"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.companyService.service.description}"
                           readonly/>
                </div>
            </div>
        <#else>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_name"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.companyService.service.nameUa}" readonly/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_description"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.companyService.service.descriptionUa}"
                           readonly/>
                </div>
            </div>
        </#if>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Price"/>: </label>
            <div class="col-sm-6">
                <input class="form-control" type="text" value="${order.price}" readonly/>
            </div>
        </div>

        <#if isCompany>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Your_comment"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" name="comment"
                           value="${order.companyComment}" ${order.done?string("readonly", "")} />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Customer_comment"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.userComment}" readonly/>
                </div>
            </div>
            <div class="form-check">
                <label>
                    <input class="form-check-input" type="checkbox" name="orderClosed" ${order.done?string("checked disabled", "")} />
                    <@spring.message "close_order"/>
                </label>
            </div>
        <#else >
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Your_comment"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" name="comment"
                           value="${order.userComment}" ${order.done?string("readonly", "")} />
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Company_comment"/>: </label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${order.companyComment}" readonly/>
                </div>
            </div>
        </#if>

        <#if order.done>
            <a class="btn btn-primary mt-3" href="${url}">OK</a>
        <#else >
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary mt-3" type="submit">
                <@spring.message "Save"/>
            </button>
        </#if>


    </form>

</@c.page>