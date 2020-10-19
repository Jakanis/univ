<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@c.page>

    <h3 class="my-4"><@spring.message "Add_new_service_to_our_company"/></h3>

    <form method="post">

        <#if .locale?starts_with("en")>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    <@spring.message "Service_name"/><@spring.message "colon"/>
                </label>
                <div class="col-sm-6">
                    <input class="form-control" disabled
                           value="${service.name}"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    <@spring.message "Service_description"/><@spring.message "colon"/>
                </label>
                <div class="col-sm-6">
                    <input class="form-control" disabled
                           value="${service.description}"/>
                </div>
            </div>
        <#else >
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    <@spring.message "Service_name"/><@spring.message "colon"/>
                </label>
                <div class="col-sm-6">
                    <input class="form-control" disabled
                           value="${service.nameUa}"/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">
                    <@spring.message "Service_description"/><@spring.message "colon"/>
                </label>
                <div class="col-sm-6">
                    <input class="form-control" disabled
                           value="${service.descriptionUa}"/>
                </div>
            </div>
        </#if>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label">
                <@spring.message "Service_price"/><@spring.message "colon"/>
            </label>
            <div class="col-sm-6">
                <input class="form-control"
                       placeholder="specify price"
                       name="price"/>
            </div>
        </div>

        <div class="form-check">
            <label>
                <input class="form-check-input" type="checkbox" name="negotiated" />
                <@spring.message "if_price_is_negotiable"/>
            </label>
        </div>

        <div class="form-group row">
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary ml-3" type="submit">
                <@spring.message "Add"/>
            </button>
        </div>
    </form>

</@c.page>