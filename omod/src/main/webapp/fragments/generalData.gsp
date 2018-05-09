<%
  	ui.includeJavascript("uicommons","moment.js")
  
    if (sessionContext.authenticated && !sessionContext.currentProvider) {
        throw new IllegalStateException("Logged-in user is not a Provider")
    }

    def genderOptions = [ [label: ui.message("emr.gender.M"), value: 'emr.gender.M'],
                          [label: ui.message("emr.gender.F"), value: 'emr.gender.F'],
						  [label: ui.message("registrationapp.person.gender.other"), value: 'registrationapp.person.gender.other']
					   ]
	
	def civilStatusOptions = [ 
		[label: ui.message("registrationapp.person.civil_status.single"), value: 'single'],
		[label: ui.message("registrationapp.person.civil_status.married"), value: 'married'],
		[label: ui.message("registrationapp.person.civil_status.divorced"), value: 'divorced'],
		[label: ui.message("registrationapp.person.civil_status.windower"), value: 'widower']
		 ]
	
	def langOptions=[ 
		[label: ui.message("emr.civil.single"), value: 'single'],
		[label: ui.message("emr.civil.married"), value: 'married'],
		[label: ui.message("emr.civil.divorced"), value: 'divorced'],
		[label: ui.message("emr.civil.widower"), value: 'widower']
		 ]
	
	def relationshipOptions=[
		[label: ui.message("registrationapp.person.relationship.child"), value: 'registrationapp.person.relationship.child'],
		[label: ui.message("registrationapp.person.relationship.ext_family"), value: 'registrationapp.person.relationship.ext_family'],
		[label: ui.message("registrationapp.person.relationship.friend"), value: 'registrationapp.person.relationship.sibling'],
		[label: ui.message("registrationapp.person.relationship.parent"), value: 'registrationapp.person.relationship.parent'],
		[label: ui.message("registrationapp.person.relationship.sibling"), value: 'registrationapp.person.relationship.sibling'],
		[label: ui.message("registrationapp.person.relationship.spouse"), value: 'registrationapp.person.relationship.spouse'],
		[label: ui.message("registrationapp.person.relationship.other"), value: 'registrationapp.person.relationship.other'],
		]
	 
	
	
	def legalOptions=[
		[label: ui.message("registrationapp.person.legal.consent"), value: 'single'],
		[label: ui.message("registrationapp.person.legal.vital_interest"), value: 'married'],
		[label: ui.message("registrationapp.person.legal.public_interest"), value: 'divorced'],
		[label: ui.message("registrationapp.person.legal.legitimate"), value: 'widower']
		]
	
	
	def benfPopType=[
		[label: ui.message("registrationapp.person.benf.detainee"), value: 'registrationapp.person.benf.detainee'],
		[label: ui.message("registrationapp.person.benf.displaced"), value: 'registrationapp.person.benf.displaced'],
		[label: ui.message("registrationapp.person.benf.refugee"), value: 'registrationapp.person.benf.refugee'],
		[label: ui.message("registrationapp.person.benf.migrant"), value: 'registrationapp.person.benf.migrant']
		]
	
	
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
		
	def livingEnvironmentList=[
		[label: ui.message("registrationapp.person.living.env.rural_dry"),value: 'registrationapp.person.living.env.rural_dry'],
		[label: ui.message("registrationapp.person.living.env.rural_wet"),value: 'registrationapp.person.living.env.rural_wet'],
		[label: ui.message("registrationapp.person.living.env.urban_dry"),value: 'registrationapp.person.living.env.urban_dry'],
		[label: ui.message("registrationapp.person.living.env.urban_wet"),value: 'registrationapp.person.living.env.urban_wet'],
		[label: ui.message("registrationapp.person.living.env.forest"),value: 'registrationapp.person.living.env.forest']
	]
	


    Calendar cal = Calendar.getInstance()
    def maxAgeYear = cal.get(Calendar.YEAR)
    def minAgeYear = maxAgeYear - 120
    def minRegistrationAgeYear= maxAgeYear - 15 // do not allow backlog registrations older than 15 years


%>

	<script>


		jq(document).ready(function () {

			jq("#next-step-2").click(function () {


			});

			jq("#fName-field").blur(function () {
				registrationData["givenName"] = jq(this).val();
			});

			jq("#mName-field").blur(function () {
				registrationData["middleName"] = jq(this).val();
			});

			jq("#lName-field").blur(function () {
				registrationData["familyName"] = jq(this).val();
			});

			jq("#gender-field").blur(function () {
				registrationData["gender"] = jq(this).val();
			});

			jq("#temporaryId-field").blur(function () {
				registrationData["temporaryId"] = "NA";
			});

			jq("#birthDate-display").change(function () {

				var dob = new Date(jq(this).val());
				var today = new Date();
				var age = Math.floor((today - dob) / (365.25 * 24 * 60 * 60 * 1000));

				var years = moment().diff('1981-01-01', 'years');
				var days = moment().diff('1981-01-01', 'days');

				jq('#age-field').val(age + ' years old');
				alert(getAge(dob));
			});


			function getAge(dateString) {

				var now = new Date();
				var today = new Date(now.getYear(), now.getMonth(), now.getDate());

				var yearNow = now.getYear();
				var monthNow = now.getMonth();
				var dateNow = now.getDate();
				//date must be mm/dd/yyyy
				var dob = new Date(dateString.substring(6, 10),
					dateString.substring(0, 2) - 1,
					dateString.substring(3, 5)
				);

				var yearDob = dob.getFullYear();
				var monthDob = dob.getMonth();
				var dateDob = dob.getDate();
				var age = {};
				var ageString = "";
				var yearString = "";
				var monthString = "";
				var dayString = "";


				yearAge = yearNow - yearDob;

				if (monthNow >= monthDob)
					var monthAge = monthNow - monthDob;
				else {
					yearAge--;
					var monthAge = 12 + monthNow - monthDob;
				}

				if (dateNow >= dateDob)
					var dateAge = dateNow - dateDob;
				else {
					monthAge--;
					var dateAge = 31 + dateNow - dateDob;

					if (monthAge < 0) {
						monthAge = 11;
						yearAge--;
					}
				}

				age = {
					years: yearAge,
					months: monthAge,
					days: dateAge
				};

				if (age.years > 1) yearString = " years";
				else yearString = " year";
				if (age.months > 1) monthString = " months";
				else monthString = " month";
				if (age.days > 1) dayString = " days";
				else dayString = " day";


				if ((age.years > 0) && (age.months > 0) && (age.days > 0))
					ageString = age.years + yearString + ", " + age.months + monthString + ", and " + age.days + dayString + " old.";
				else if ((age.years == 0) && (age.months == 0) && (age.days > 0))
					ageString = "Only " + age.days + dayString + " old!";
				else if ((age.years > 0) && (age.months == 0) && (age.days == 0))
					ageString = age.years + yearString + " old. Happy Birthday!!";
				else if ((age.years > 0) && (age.months > 0) && (age.days == 0))
					ageString = age.years + yearString + " and " + age.months + monthString + " old.";
				else if ((age.years == 0) && (age.months > 0) && (age.days > 0))
					ageString = age.months + monthString + " and " + age.days + dayString + " old.";
				else if ((age.years > 0) && (age.months == 0) && (age.days > 0))
					ageString = age.years + yearString + " and " + age.days + dayString + " old.";
				else if ((age.years == 0) && (age.months > 0) && (age.days == 0))
					ageString = age.months + monthString + " old.";
				else ageString = "Oops! Could not calculate age!";

				return ageString;
			}



		});
	</script>

	<div class="row">
		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text",[id:"fName",label:"First Name",formFieldName:"givenName",classes:['form-control',"required"]])}
		</div>
		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text",[id:"mName",label:"Middle Name",formFieldName:"middleName",classes:['form-control']])}
		</div>
		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text",[id:"lName",label:"Last Name",formFieldName:"familyName",classes:['form-control']])}
		</div>
	</div>

	<div class=row>
		<div class="col-lg-4">

			${ ui.includeFragment("uicommons", "field/datetimepicker", [ id: "birthDate", formFieldName: "birthDate", label: "Date of
			Birth", defaultDate: new Date(), useTime: false, classes:["form-control"] ])}
		</div>

		<div class="col-lg-4">


			${ui.includeFragment("uicommons","field/checkbox", [id: "approximate", formFieldName: "approximate", initialValue: "", label:"Approximate",
			hideEmptyLabel: true, ]) }
		</div>
		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "age", formFieldName: "age", initialValue: "", label:"Age", hideEmptyLabel:
			true, classes:['requiredField'], classes:["form-control"] ]) }

		</div>
	</div>
	<div class="row">
		<div class="col-lg-4">

			${ui.includeFragment("uicommons","field/dropDown", [id: "gender", formFieldName: "gender", options: genderOptions, initialValue:
			"", classes: ["requiredField"], hideEmptyLabel: true, label:"Gender", classes:["form-control"], expanded: false]) }
		</div>

		<div class="col-lg-4">

			${ui.includeFragment("uicommons","field/dropDown", [id: "civilStatus", formFieldName: "civilStatus", options: civilStatusOptions,
			initialValue: "", classes:["form-control"], hideEmptyLabel: true, label:"Civil Status", expanded: false]) }

		</div>

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/dropDown", [id: "benfPoplationType", formFieldName: "benfPoplationType", initialValue:
			"", classes:["form-control"], options: benfPopType, label:"Beneficiary Population Type", hideEmptyLabel: true, expanded:
			false]) }

		</div>


	</div>

	<div class="row">

		<div class="col-lg-4">

			${ui.includeFragment("uicommons","field/text", [id: "country", formFieldName: "country", initialValue: "", classes:["form-control"],
			label:"Country", hideEmptyLabel: true ]) }
		</div>

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "adminLevel1", formFieldName: "adminLevel1", initialValue: "", label:"Admin
			Level 1", classes:['form-control'], hideEmptyLabel: true ]) }
		</div>



		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "adminLevel2", formFieldName: "adminLevel2", initialValue: "", classes:["form-control"],
			label:"Admin Level 2", hideEmptyLabel: true ]) }
		</div>
	</div>
	<div class="row">

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "adminLevel3", formFieldName: "adminLevel3", initialValue: "", label:"Admin
			Level 3", classes:['form-control'], hideEmptyLabel: true ]) }
		</div>

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "adminLevel4", formFieldName: "adminLevel4", initialValue: "", classes:["form-control"],
			label:"Admin Level 4", hideEmptyLabel: true ]) }
		</div>

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "street", formFieldName: "street", initialValue: "", label:"Street",
			classes:["form-control"], hideEmptyLabel: true ]) }
		</div>
	</div>

	<div class="row">
		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/dropDown", [id: "livingEnvironment", formFieldName: "livingEnvironment", initialValue:
			"", classes:["form-control"], label:"Living Environment", options:livingEnvironmentList, hideEmptyLabel: true, expanded:
			false]) }
		</div>
		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "telephone", formFieldName: "telephone", initialValue: "", classes:["form-control"],
			label:"Telephone", hideEmptyLabel: true, expanded: false]) }
		</div>

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "email", formFieldName: "email", initialValue: "", label:"Email", classes:["form-control"],
			hideEmptyLabel: true ]) }
		</div>

	</div>

	<div class="row">

		<div class="col-lg-4">

			${ui.includeFragment("uicommons","field/contact", [id: "emergencyContact", label:"Emergency Contact", relationshipOptions:
			relationshipOptions]) }
		</div>

		<div class="col-lg-4">

			${ui.includeFragment("uicommons","field/contact", [id: "backupContact", label:"Backup Contact", relationshipOptions: relationshipOptions])
			}
		</div>

		<div class="col-lg-4">
			${ui.includeFragment("uicommons","field/text", [id: "languages", formFieldName: "languages", initialValue: "", label:"Languages
			Spoken", classes:['form-control'], hideEmptyLabel: true, expanded: true]) }
		</div>
	</div>