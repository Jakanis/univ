<#import "parts/common.ftl" as c>
<#import "parts/pager.ftl" as p>
<#import "/spring.ftl" as spring/>

<@c.page>
  <div class="mb-3">
    <@spring.message "list_of_users"/>
  </div>

  <@p.pager url page />

  <table class="table table-striped">
    <thead>
    <tr>
      <th scope="col"><@spring.message "Name"/></th>
      <th scope="col"><@spring.message "Role"/></th>
      <th scope="col"></th>
    </tr>
    </thead>
    <tbody>
    <#list page.content as user>
      <tr>
        <td>${user.username}</td>
        <td><#list user.roles as role>${role}<#sep>, </#list></td>
        <td>
          <a href="/user/${user.id}">
            <@spring.message "edit"/>
          </a>
        </td>
      </tr>
    </#list>
    </tbody>
  </table>

  <@p.pager url page />

</@c.page>