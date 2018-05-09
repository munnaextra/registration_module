
<% config.require("id") %>
<div class="row setup-content" id="${config.id}">
  <div class="col-xs-12">
    <div class="col-md-12" style="min-height:400px;">
      <h3> ${config.header} </h3>
	  ${ui.includeFragment(config.fragmentProvider,config.fragmentName,config.options)} 	
    </div>
     ${ui.includeFragment("registrationapp","navigatorButtons",[id:config.id])}
  </div>
  
</div>
