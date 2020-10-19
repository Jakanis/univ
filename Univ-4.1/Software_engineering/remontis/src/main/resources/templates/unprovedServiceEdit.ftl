<#import "parts/common.ftl" as c>
<#import "/spring.ftl" as spring/>

<@c.page>
  <div class="mb-4">
    <h4><@spring.message "Service_editor"/></h4>
  </div>

  <form id="save-form" action="/proveServices" method="post">
    <div class="form-group row">
      <label class="col-sm-2 col-form-label"><@spring.message "Name"/> <@spring.message "in_english"/></label>
      <div class="col-sm-6">
        <input class="form-control" type="text" name="name" value="${myService.name}"/>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label"><@spring.message "Name"/> <@spring.message "in_ukrainian"/></label>
      <div class="col-sm-6">
        <input class="form-control" type="text" name="nameUa" value="${myService.nameUa}"/>
      </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2 col-form-label"><@spring.message "Description"/> <@spring.message "in_english"/></label>
        <div class="col-sm-6">
            <input class="form-control" type="text" name="description" value="${myService.description}"/>
          </div>
        </div>
        <div class="form-group row">
          <label class="col-sm-2 col-form-label"><@spring.message "Description"/> <@spring.message "in_ukrainian"/></label>
          <div class="col-sm-6">
            <input class="form-control" type="text" name="descriptionUa" value="${myService.descriptionUa}"/>
          </div>
        </div>


    <input type="hidden" value="${myService.id}" name="myServiceId"/>
    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

    <input type="hidden" id="action" name="action"/>
    <button type="submit" name="declined" id="modalDeclineTrigger"
            class="btn btn-primary mt-3">
      <@spring.message "Save"/>
    </button>
    <button type="submit" name="accepted" id="modalAcceptTrigger"
            class="btn btn-primary mt-3">
      <@spring.message "Decline"/>
    </button>

  </form>

  <script>
    $('#modalAcceptTrigger').on('click', function () {
      $('#action').val('decline');
      $('#save-form').submit();
    });
    $('#modalDeclineTrigger').on('click', function () {
      $('#action').val('accept');
      $('#save-form').submit();
    });
  </script>

</@c.page>