<% ui.decorateWith("appui", "standardEmrPage")
 
 ui.includeJavascript("registrationapp","stepperHelper.js")
 
 ui.includeCss("registrationapp","stepper.css")
 
 
 
	ui.includeJavascript("registrationapp", "webcam.js")
	ui.includeJavascript("registrationapp", "jquery.form.js")
 
 
%>

	<style>
		#signatureparent {
			color: darkblue;
			background-color: lightgrey;
			padding: 15px;
			max-size: 824px;
		}

		#signature {
			padding: 0 0 0 0;
			margin: 0 0 0 0;
			border: 2px dotted #000;
			width: 75%;
		}
	</style>

	<script>
		var jq = jQuery;
		var breadcrumbs = [];
		var sig;
		var registrationData = {
			givenName: "",
			middleName: "",
			lastName: "",
			temporaryId: "",
			gender: "",
			address: ""
		};

		function validateFields() {
			jq('.requiredField').each(function () {
				var fieldValue = jq(this).val();
				if (fieldValue == 'undefined' || fieldValue == 'NaN' || fieldValue == 'null' || fieldValue === '') {
					return false;
				}
			});
			return true;
		}

		//Hides consent processes and shows the buttons
		function hideConsent() {
			jq("#paperConsentForm").hide();
			jq("#digitalConsentProcess").hide();
			jq("#paperConsentFormAlreadySigned").hide();
			jq("#consentProcess").show();
		}

		jq(document).ready(function () {


			jq("#cnfRegAnother").click(function (e) {
				submitForm(e);
			})
			jq("#cnfSaveDUser").click(function (e) {
				submitForm(e);
			})
			jq("#cnfSchInitAssesment").click(function (e) {
				submitForm(e);
			})

			//Hides consent forms so that they can be repopulate next time they are opened
			jq("#next-step-3").click(function () { hideConsent(); })
			jq("#prev-step-5").click(function () { hideConsent(); })
			jq('a[href="#step-4"]').click(function () { hideConsent(); })

			jq("#next-step-2").click(function (e) {
				getSimilarPatients(e);
			});

			sig = jq("#signature").jSignature();
		});






		/*TFS 82775*/
		function getSimilarPatients(e) {
			var formData = jq('#registration').serialize();
			var url = '/' + OPENMRS_CONTEXT_PATH + '/registrationapp/matchingPatients/getExactPatients.action?appId=registrationapp.basicRegisterPatient';
			jq.post(url, formData, function (data) {
				if (data.length == 0) {
					submitForm(field);
				} else {
					var familyName;
					var len = data.length;
					var urlPath = '/' + OPENMRS_CONTEXT_PATH + '/coreapps/clinicianfacing/patient.page?patientId=';

					if (len > 0) {
						jq("#similarPatientList > tbody").html("");
						var txt;
						for (var i = 0; i < len; i++) {
							familyName = ((data[i].familyName == null) ? '' : data[i].familyName);
							
							/* TODO: Externalize 'Existing HSU' (to be called as TFS "Confirm Match", display it as a button  */

							txt += "<tr><td>" + data[i].givenName + ' ' + familyName + "</td><td>" + data[i].birthdate + "</td><td>" + data[i].personAddress + "</td><td>" +
								'<a href="' + urlPath + data[i].uuid + '">Existing HSU</a>' + "</td></tr>";

						}
						jq('#similarPatientList').append('<tbody>' + txt + '</tbody>');
					}

					DtableFlag = 1;
					jq("#similarPatientList").addClass("DataTable");



					submitionDialogBox = emr.setupConfirmationDialog({
						selector: '#submitionDialogueBox',
						actions: {
							cancel: function () {
								submitionDialogBox.close();
							},
							confirm: function () {
								submitionDialogBox.close();
								submitForm(field, reqType);
							}
						}
					});
					submitionDialogBox.show();
					return false;
				}

			}, "json");


		};



		function submitForm(e) {
			e.preventDefault();
			jq('#submit').attr('disabled', 'disabled');
			jq('#cancelSubmission').attr('disabled', 'disabled');
			jq('#validation-errors').hide();
			var formData = jq('#registration').serialize();

			var url = '/' + OPENMRS_CONTEXT_PATH + '/registrationapp/registerPatient/submit.action?appId=registrationapp.basicRegisterPatient';


			jq.ajax({
				url: url,
				type: "POST",
				data: formData,
				dataType: "json",
				success: function (response) {
					emr.navigateTo({ "applicationUrl": response.message });
				},
				error: function (response) {
					jq('#validation-errors-content').html(response.responseJSON.globalErrors);
					jq('#validation-errors').show();
					jq('#submit').removeAttr('disabled');
					jq('#cancelSubmission').removeAttr('disabled');
				}
			});

		};

	</script>

	<div class="container-fluid">

		<div class="stepwizard">
			<div class="stepwizard-row setup-panel ">
				<div class="stepwizard-step">
					<a href="#step-1" type="button" class="btn firstStep btn-primary btn-circle">1</a>
					<h1 id="nav-step-1"></h1>
				</div>

				<div class="stepwizard-step">
					<a href="#step-2" type="button" class="btn btn-primary btn-circle">2</a>
					<h1 id="nav-step-2"></h1>
				</div>

				<div class="stepwizard-step">
					<a href="#step-3" type="button" class="btn btn-primary btn-circle">3</a>
					<h1 id="nav-step-3"></h1>
				</div>

				<div class="stepwizard-step">
					<a href="#step-4" type="button" class="btn btn-primary btn-circle">4</a>
					<h1 id="nav-step-4"></h1>
				</div>


				<div class="stepwizard-step">
					<a href="#step-5" type="button" class="btn btn-primary btn-circle">5</a>
					<h1 id="nav-step-5"></h1>
				</div>

				<div class="stepwizard-step">
					<a href="#step-6" type="button" class="btn btn-primary btn-circle">6</a>
					<h1 id="nav-step-6"></h1>
				</div>

				<div class="stepwizard-step">
					<a href="#step-7" type="button" class="btn btn-primary btn-circle">7</a>
					<h1 id="nav-step-7"></h1>
				</div>
			</div>
		</div>
		<form class="form-horizontal" role="form" id="registration" method="post">



			${ui.includeFragment("registrationapp","registrationStep", [id:"step-1",header:"Select Legal Basis", fragmentProvider:"registrationapp",
			fragmentName:"legalBasis", options:[formFieldName:"name",id:"nameId",label:"Name"]])} ${ui.includeFragment("registrationapp","registrationStep",
			[id:"step-2",header:"HSU General Data",fragmentProvider:"registrationapp", fragmentName:"generalData"])} ${ui.includeFragment("registrationapp","registrationStep",
			[id:"step-3",header:"PRP Specific Data",fragmentProvider:"registrationapp", fragmentName:"prpCenterData"])} ${ui.includeFragment("registrationapp","registrationStep",
			[id:"step-4",header:"Consent Form",fragmentProvider:"registrationapp", fragmentName:"step/dataConsent"])} ${ui.includeFragment("registrationapp","registrationStep",
			[id:"step-5",header:"Confirm Legal Basis",fragmentProvider:"registrationapp", fragmentName:"step/confirmLegalBasis"])}
			${ui.includeFragment("registrationapp","registrationStep", [id:"step-6",header:"Confirm Legal Basis",fragmentProvider:"registrationapp",
			fragmentName:"step/captureAndUploadPhoto"])} ${ui.includeFragment("registrationapp","registrationStep", [id:"step-7",header:"Confirm
			Legal Basis",fragmentProvider:"registrationapp", fragmentName:"step/confirmRegistration"])}

		</form>
	</div>
	<!-- TFS 82775 -->
	<div id="submitionDialogueBox" class="dialog" style="display: none; left: 0; right: 0; top: 20%; bottom: 0; position: absolute; height: 350px; border: solid 1px #ccc; width: 80%;">
		<div class="dialog-header">
			<i class="icon-info-sign"></i>
			<h3>${ui.message("registrationapp.patient.similarHSU.label")}</h3>
		</div>

		<div class="dialog-content">
			<p class="dialog-instructions">
			</p>
			<div class='table-responsive'>
				<table id="similarPatientList">
					<thead>
						<th>${ui.message("registrationapp.patient.name.label")}</th>
						<th>Emergency Contact Phone</th>
						<th>${ui.message("registrationapp.patient.action.label")}</th>
						<th>${ui.message("registrationapp.patient.action.label")}</th>
					</thead>

				</table>
			</div>
			<div class="btn">
				<button class="cancel" id="CloseDialogBox">
					${ui.message("registrationapp.cancel")}</button>
			</div>
			<div class="btn" style="width: 750px;">
				<button class="submitButton confirm right">
					${ui.message("registrationapp.patient.newHSU.label")}</button>
			</div>
		</div>
	</div>
	</div>