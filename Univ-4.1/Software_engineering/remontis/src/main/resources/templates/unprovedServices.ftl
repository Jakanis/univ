<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#import "/spring.ftl" as spring/>

<@c.page>
    <div class="mb-3">
        <@spring.message "list_of_unproved_services"/>
    </div>

    <@p.pager url page />

    <div class="card-columns">
        <#list page.content as service>
            <div class="card my-3">
                <span>${service.name}</span><br>
                <span>${service.nameUa}</span><br>
                <span>${service.description}</span><br>
                <span>${service.descriptionUa}</span><br>
                    <a href="/proveServices/${service.id}">
                        <@spring.message "edit"/>
                    </a>
            </div>
        <#else>
            <@spring.message "No_unproved_services"/>
        </#list>
    </div>

    <@p.pager url page />

</@c.page>