<% 
ui.includeCss("registrationapp","digitalSignatureStyle.css") 
ui.includeJavascript("registrationapp","jSignature.min.noconflict.js")
ui.includeJavascript("registrationapp", "jspdf/jspdf.min.js")
ui.includeJavascript("registrationapp", "consentPdfPrint.js")
%>

	<script>

		jq(document).ready(function () {

			jq("#trDigitalConsentProcessBtn").click(function (e) {
				e.preventDefault();
				jq("#trPaperConsentFormAlreadySigned").hide();
				jq("#trPaperConsentForm").hide();
				jq("#trDigitalConsentProcess").show();
				jq("#trConsentProcess").hide();
				//TODO: Fetch these fields if we don't have them when the initial assessment workflow is done.
				jq("#trFNameId").text(registrationData["givenName"]);
				jq("#trMNameId").text(registrationData["middleName"]);
				jq("#trLNameId").text(registrationData["familyName"]);
				//TODO: fix this to get the HSU ID
				jq("#trHsuId").text(jq("#legacyId-field").val())

			});

			jq("#trPaperConsentFormBtn").click(function (e) {
				e.preventDefault();
				fillConsentForm();
				jq("#trPaperConsentFormAlreadySigned").hide();
				jq("#trDigitalConsentProcess").hide();
				jq("#trPaperConsentForm").show();
				jq("#trConsentProcess").hide();

			});


			jq("#trPaperConsentFormAlreadySignedBtn").click(function (e) {
				e.preventDefault();
				jq("#trPaperConsentForm").hide();
				jq("#trDigitalConsentProcess").hide();
				jq("#trPaperConsentFormAlreadySigned").show();
				jq("#trConsentProcess").hide();

			});

			jq("#trPrint-consent-button").click(function (e) {
				e.preventDefault();
				printMe("trPaper-consent-form");
			});

			jq(".close-consent-button").click(function (e) {
				e.preventDefault();
				jq("#trPaperConsentForm").hide();
				jq("#trDigitalConsentProcess").hide();
				jq("#trPaperConsentFormAlreadySigned").hide();
				jq("#trConsentProcess").show();
			});
		});
	</script>

	<div id="trConsentProcess">
		<h2>${ui.message("registrationapp.selectConsentProcess")}</h2>
		<button class="btn btn-primary trConsentButtons" id="trDigitalConsentProcessBtn">${ui.message("registrationapp.generateDigitalConsent")}</button>
		<button class="btn btn-primary trConsentButtons" id="trPaperConsentFormBtn">${ui.message("registrationapp.generatePaperConsent")}</button>
		<button class="btn btn-primary trConsentButtons" id="trPaperConsentFormAlreadySignedBtn">${ui.message("registrationapp.attachPaperConsent")}</button>
	</div>


	<section class="pad-res" id="trDigitalConsentProcess" style="display:none;">
		<h4>Digital Consent Form</h4>
		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("First Name")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="trFNameId"></p>
			</div>
			<div class="col-lg-2">
				<strong>${ui.message("Middle Name")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="trMNameId"></p>
			</div>
			<div class="col-lg-2">
				<strong>${ui.message("Last Name")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="trLNameId"></p>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("registrationapp.patient.HSUID")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="trHsuId"></p>
			</div>

		</div>

		${ui.includeFragment("registrationapp","treatmentConsentInformation")}

		<button class="cancel close-consent-button">${ui.message("registrationapp.cancel")}</button>
	</section>

	<section id="trPaperConsentForm" style="display:none;">
		<h4>${ ui.message("registrationapp.generatePaperConsent") }</h4>
		<div id="trPaper-consent-form">
			<p>
				<h3 class="title">${ ui.message("registrationapp.treatmentConsent.form.1") }</h3>
			</p>
			<p>
				${ ui.message("registrationapp.patient.givenName.label") }:
				<b id="trConsent-form-given_name"> </b>, ${ ui.message("registrationapp.patient.middleName.label") }:
				<b id="trConsent-form-middle_name"> </b>, ${ ui.message("registrationapp.patient.familyName.label") }:
				<b id="trConsent-form-family_name"> </b>, ${ ui.message("registrationapp.patient.birthdate.label") }:
				<b id="trConsent-form-hsu_id"> </b>, ${ ui.message("registrationapp.patient.HSUID") }:
			</p>
			<p> ${ ui.message("registrationapp.treatmentConsent.form.2", "XXXX") } </p>
			<p> ${ ui.message("registrationapp.treatmentConsent.form.3") }
				<b>${ ui.message("registrationapp.basicTreatment") }</b>
			</p>
			<p> ${ ui.message("registrationapp.treatmentConsent.form.4") } </p>
			<p> ${ ui.message("registrationapp.treatmentConsent.form.5") } </p>
			<p> ${ ui.message("registrationapp.treatmentConsent.form.6") } </p>
			<p> ${ ui.message("registrationapp.treatmentConsent.form.7") } </p>
			<p>
				<span>${ ui.message("registrationapp.dataConsent.form.signature") }</span>
			</p>
			<br>
			<br>
			<br>
			<br>
			<br>
			<p>
				<span>
					${ ui.message("registrationapp.dataConsent.form.patient") }____________________
				</span>
				<span style="margin-left: 150px">
					${ ui.message("registrationapp.dataConsent.form.signature") }____________________
				</span>
			</p>
			<p>
				${ ui.message("registrationapp.dataConsent.form.date") }____________________
			</p>
		</div>
		<div>
			<button class="confirm" id="trPrint-consent-button">${ ui.message("uicommons.print") }</button>
			<button class="cancel close-consent-button">${ui.message("registrationapp.cancel")}</button>
		</div>
		</div>
	</section>



	<section id="trPaperConsentFormAlreadySigned" style="display:none;">
		${ui.includeFragment("registrationapp","step/alreadySignedForm")}
		<button class="cancel close-consent-button">${ui.message("registrationapp.cancel")}</button>
	</section>