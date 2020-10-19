<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as spring/>

<@c.page>

    <#if feedback?has_content>
        <p class="my-4"><@spring.message "This_is_your_previous_feedback_about"/> ${company.username}. <@spring.message "You_can_change_it"/>.</p>
        <form method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Grade"/></label>
                <div class="col-sm-6">
                    <input class="form-control" type="number" min="1" max="5" name="grade" value="${feedback.grade}" />
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Feedback"/></label>
                <div class="col-sm-6">
                    <input class="form-control" type="text" name="feedback" value="${feedback.feedback}" />
                </div>
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary mt-3" type="submit">
                <@spring.message "Save"/>
            </button>
        </form>
    <#else >
        <p class="my-4"><@spring.message "You_dint_leave_feedback_on"/> ${company.username}. <@spring.message "Just_do_it"/>.</p>
        <form method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Grade"/></label>
                <div class="col-sm-6">
                    <input class="form-control" name="grade" type="number" min="1" max="5" value="1"/>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label"><@spring.message "Feedback"/></label>
                <div class="col-sm-6">
                    <input class="form-control" name="feedback" type="text" />
                </div>
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button class="btn btn-primary mt-3" type="submit">
                <@spring.message "Save"/>
            </button>
        </form>
    </#if>

</@c.page>