<%
    if (sessionContext.authenticated && !sessionContext.currentProvider) {
        throw new IllegalStateException("Logged-in user is not a Provider")
    }
    
	def occList=[
		[label: ui.message("registrationapp.person.occupation.armed_forces"), value: 'registrationapp.person.occupation.armed_forces'],
		[label: ui.message("registrationapp.person.occupation.farmer"), value: 'registrationapp.person.occupation.farmer'],
		[label: ui.message("registrationapp.person.occupation.techincaian"), value: 'registrationapp.person.occupation.techincaian'],
		[label: ui.message("registrationapp.person.occupation.office_worker"), value: 'registrationapp.person.occupation.office_worker'],
		[label: ui.message("registrationapp.person.occupation.unemployed"), value: 'registrationapp.person.occupation.unemployed'],
		[label: ui.message("registrationapp.person.occupation.student"), value: 'registrationapp.person.occupation.student'],
		[label: ui.message("registrationapp.person.occupation.housekeeper"), value: 'registrationapp.person.occupation.housekeeper'],
		[label: ui.message("registrationapp.person.occupation.deminer_forces"), value: 'registrationapp.person.occupation.deminer_forces'],
		[label: ui.message("registrationapp.person.occupation.child"), value: 'registrationapp.person.occupation.child'],
		]
		
	def hdykList=[
	
		[label: ui.message("registrationapp.person.hdyk.media"),value: 'registrationapp.person.hdyk.media'],
		[label: ui.message("registrationapp.person.hdyk.referral"),value: 'registrationapp.person.hdyk.referra'],
		[label: ui.message("registrationapp.person.hdyk.outreach"),value: 'registrationapp.person.hdyk.outreach'],
		[label: ui.message("registrationapp.person.hdyk.wom"),value: 'registrationapp.person.hdyk.wom'],
		[label: ui.message("registrationapp.person.hdyk.other"),value: 'registrationapp.person.hdyk.other']
	];
	
	def statusList=[
		[label: ui.message("registrationapp.person.status.active"),value: 'registrationapp.person.status.active'],
		[label: ui.message("registrationapp.person.status.inactive"),value: 'registrationapp.person.status.inactive'],
		]
		
		
	
	
	
%>
<div class="row">

	<div class="col-lg-4">
		
		${ui.includeFragment("uicommons","field/text",
					[id: "legacyId",
	                formFieldName: "legacyID",
	                initialValue: "",
	                label:"Legacy ID",
	                classes:["form-control"],
	                hideEmptyLabel: true,
                	expanded: false])	}
	</div>	
	<div class="col-lg-4">
			
		${ui.includeFragment("uicommons","field/dropDown",
					[ id: "occupationAtEvent",
		              formFieldName: "occupationAtEvent",
		              initialValue: "",
		              options: occList,
		              classes:["form-control", "minimal"],
		              label:"Occupation at the time of event",
		              hideEmptyLabel: true,
		              expanded: false])	}	
	</div>	
	<div class="col-lg-4">
			
		${ui.includeFragment("uicommons","field/dropDown",
					[ id: "currentOccupation",
		              formFieldName: "currentOccupation",
		              initialValue: "",
		              classes:["form-control", "minimal"],
		              options: occList,
		              label:"Current Occupation",
		              hideEmptyLabel: true,
		              expanded: false])	}	
	</div>	
	
</div>		
	
<div class="row">		
	<div class="col-lg-4">
		${ui.includeFragment("uicommons","field/dropDown",
					[id: "hdykList",
					 label:"How did you know the PRC ?",
	                 formFieldName: "hdyk",
	                 initialValue: "",
	                 options: hdykList,
	                 classes:["form-control"],
	                 hideEmptyLabel: true,
	                 expanded: false
					])	}						
	</div>	
	<div class="col-lg-4">	
		${ui.includeFragment("uicommons","field/dropDown",
					[ id: "occupation",
	                  formFieldName: "status",
	                  initialValue: "",
	                  options: statusList,
	                  classes:["form-control", "minimal"],
	                  label:"Status",
	                  hideEmptyLabel: true,
	                  expanded: false])	}
    </div>
    <div class="col-lg-4">	
		${ ui.includeFragment("uicommons", "field/datetimepicker", [
                            id: "registrationDate",
                            formFieldName: "registrationDate",
                            label: "Registration Date",
                            useTime: false,
                    ])}
    </div>
</div>		
