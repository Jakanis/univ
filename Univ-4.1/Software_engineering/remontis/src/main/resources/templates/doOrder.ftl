<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <h3 class="my-4"><@spring.message "Do_order"/>:</h3>

    <form method="post">
        <#if .locale?starts_with("en")>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_name"/></label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${companyService.service.name}" readonly/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_description"/></label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${companyService.service.description}" readonly/>
                </div>
            </div>
        <#else >
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_name"/></label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${companyService.service.nameUa}" readonly/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Service_description"/></label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" value="${companyService.service.descriptionUa}" readonly/>
                </div>
            </div>
        </#if>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Service_price"/></label>
            <div class="col-sm-6">
                <input class="form-control" type="text" value="${companyService.price}" readonly/>
            </div>
        </div>
        <#if companyService.negotiated>
            <#assign negotiated = 'You_can_talk_about_price'
            color = 'green'>
        <#else>
            <#assign negotiated = 'You_cannot_talk_about_price'
            color = 'red'>
        </#if>
        <span style="color: ${color}"><@spring.message "${negotiated}"/></span><br>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Leave_your_comment_optionally"/></label>
            <div class="col-sm-6">
                <input class="form-control" type="text" name="comment" />
            </div>
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button class="btn btn-primary mt-3" type="submit">
            <@spring.message "Order"/>
        </button>
    </form>

</@c.page>