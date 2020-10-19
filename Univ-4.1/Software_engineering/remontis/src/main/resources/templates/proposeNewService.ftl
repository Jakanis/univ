<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as spring/>

<@c.page>
    <div class="mb-4">
        <h4><@spring.message "Propose_new_service"/></h4>
    </div>

    <form id="save-form" action="/propose_new_service" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Name"/> <@spring.message "in_english"/></label>
            <div class="col-sm-6">
                <input class="form-control" type="text" name="name" />
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Name"/> <@spring.message "in_ukrainian"/></label>
            <div class="col-sm-6">
                <input class="form-control" type="text" name="nameUa" />
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Description"/> <@spring.message "in_english"/></label>
            <div class="col-sm-6">
                <input class="form-control" type="text" name="description" />
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "Description"/> <@spring.message "in_ukrainian"/></label>
            <div class="col-sm-6">
                <input class="form-control" type="text" name="descriptionUa" />
            </div>
        </div>

        <input type="hidden" name="_csrf" value="${_csrf.token}"/>

        <button type="submit" class="btn btn-primary mt-3">
            <@spring.message "Propose"/>
        </button>

    </form>

</@c.page>