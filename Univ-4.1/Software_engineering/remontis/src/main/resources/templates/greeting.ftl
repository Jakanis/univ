<#import "parts/common.ftl" as common>
<#include "parts/security.ftl">
<#import "/spring.ftl" as spring/>

<@common.page>
    <div class = "text-center" style="position: relative;">
        <img src="https://randysrepairsca.com/wp-content/uploads/2019/12/Electronic-Repair.jpg" class="img-fluid" alt="Responsive image">
        <div style = "position: absolute;top: 45%;left: 0;width: 100%;color: white;font-size:600%;font-weight: bold;">
            <p style="top:50%;left:50%">Remontis</p>
        </div>
    </div>
    <div>
        <@spring.message "welcome_to"/>
    </div>
</@common.page>