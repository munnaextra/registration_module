<% def legalOptions=[
		[label: ui.message("Select Legal Basis"), value: ''],
		[label: ui.message("registrationapp.person.legal.consent"), value: 'consent'],
		[label: ui.message("registrationapp.person.legal.vital_interest"), value: 'vital_interest'],
		[label: ui.message("registrationapp.person.legal.public_interest"), value: 'public_interest'],
		[label: ui.message("registrationapp.person.legal.legitimate"), value: 'legitimate']
		]
		
%>

<script>
	
	jq(document).ready(function (){
	jq("#legalBasis-field").change(function(){
		if(jq("#legalBasis-field").val()!=''){
			jq("#anonymousHSU-field").prop("disabled", true);
		}else{
			jq("#anonymousHSU-field").prop("disabled", false);
		}
	});
	
	
	jq('input:checkbox').change(
    function(){
        if (jq('#anonymousHSU-field').is(':checked')) {
        	 jq("#legalBasis-field").prop("disabled", true);
      	  }else{
      		 jq("#legalBasis-field").prop("disabled", false); 
      	  }
    });
				
	});
	
</script>


<div class="row">
<div class="col-lg-12">

<div class="row">

	<div class="col-md-6">

	${ ui.includeFragment("uicommons", "field/dropDown", [
	                            id: "legalBasis",
	                            formFieldName: "legalBasis",
	                            initialValue: "",
	                            options: legalOptions,
	                            classes:[""],
	                            label:"Select Legal Basis",
	                            hideEmptyLabel: true,
	                            expanded: false
	                    ])}
	
	</div>
	
	<div class="col-md-6">
	
	
	${ ui.includeFragment("uicommons", "field/checkbox", [
	                            id: "anonymousHSU",
	                            formFieldName: "anonymousHSU",
	                            initialValue: "",
	                            label:"Register Anonymous HSU",
	                            hideEmptyLabel: true
	                    ])}
                    
</div>



</div>


</div>


</div>