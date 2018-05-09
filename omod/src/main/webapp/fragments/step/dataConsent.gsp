<% 
ui.includeCss("registrationapp","digitalSignatureStyle.css") 
ui.includeJavascript("registrationapp","jSignature.min.noconflict.js")
ui.includeJavascript("registrationapp", "jspdf/jspdf.min.js")
ui.includeJavascript("registrationapp", "consentPdfPrint.js")
%>

	<script>

		emr.loadMessages([
			"emr.gender.M",
			"emr.gender.F"
		]);
		jq(document).ready(function () {

			jq("#digitalConsentProcessBtn").click(function (e) {
				e.preventDefault();
				jq("#paperConsentFormAlreadySigned").hide();
				jq("#paperConsentForm").hide();
				jq("#digitalConsentProcess").show();
				jq("#consentProcess").hide();
				jq("#patName").text(registrationData["givenName"] + ' ' + registrationData["middleName"] + ' ' + registrationData["familyName"]);
				jq("#fNameId").text(registrationData["givenName"]);
				jq("#mNameId").text(registrationData["middleName"]);
				jq("#lNameId").text(registrationData["familyName"]);
				jq("#dobId").text(jq("#birthDate-display").val())

				jq("#genderId").text(window.messages[jq("#gender-field").val()])


				var d = new Date();

				var month = d.getMonth() + 1;
				var day = d.getDate();

				var regdDate = day + '/' +
					(month < 10 ? '0' : '') + month + '/' +
					(day < 10 ? '0' : '') + d.getFullYear();

				jq("#regdDate").text(regdDate)

				var ctr = jq("#country-field").val()
				var lev1 = jq("#adminLevel1-field").val()
				var lev2 = jq("#adminLevel2-field").val()
				var lev3 = jq("#adminLevel3-field").val()
				var lev4 = jq("#adminLevel4-field").val()
				var street = jq("#street-field").val()
				var address = formatAddress()

				jq("#addressId").text(address)


			});

			jq("#paperConsentFormBtn").click(function (e) {
				e.preventDefault();
				fillConsentForm();
				jq("#paperConsentFormAlreadySigned").hide();
				jq("#digitalConsentProcess").hide();
				jq("#paperConsentForm").show();
				jq("#consentProcess").hide();

			});


			jq("#paperConsentFormAlreadySignedBtn").click(function (e) {
				e.preventDefault();
				jq("#paperConsentForm").hide();
				jq("#digitalConsentProcess").hide();
				jq("#paperConsentFormAlreadySigned").show();
				jq("#consentProcess").hide();

			});

			jq("#print-consent-button").click(function (e) {
				e.preventDefault();
				printMe("paper-consent-form");
			});

			jq(".close-consent-button").click(function (e) {
				e.preventDefault();
				jq("#paperConsentForm").hide();
				jq("#digitalConsentProcess").hide();
				jq("#paperConsentFormAlreadySigned").hide();
				jq("#consentProcess").show();
			});
		});
	</script>

	<div id="consentProcess">
		<h2>${ui.message("registrationapp.selectConsentProcess")}</h2>
		<button class="btn btn-primary consentButtons" id="digitalConsentProcessBtn">${ui.message("registrationapp.generateDigitalConsent")}</button>
		<button class="btn btn-primary consentButtons" id="paperConsentFormBtn">${ui.message("registrationapp.generatePaperConsent")}</button>
		<button class="btn btn-primary consentButtons" id="paperConsentFormAlreadySignedBtn">${ui.message("registrationapp.attachPaperConsent")}</button>
	</div>


	<section class="pad-res" id="digitalConsentProcess" style="display:none;">
		<h4>Digital Consent Form</h4>
		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("First Name")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="fNameId"></p>
			</div>
			<div class="col-lg-2">
				<strong>${ui.message("Middle Name")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="mNameId"></p>
			</div>
			<div class="col-lg-2">
				<strong>${ui.message("Last Name")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="lNameId"></p>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("Date Of Birth")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="dobId"></p>
			</div>

		</div>


		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("Registration Date")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="regdDate"></p>
			</div>
		</div>


		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("Gender")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="genderId"></p>
			</div>
		</div>



		<div class="row">
			<div class="col-lg-2">
				<strong>${ui.message("Address")}</strong>
			</div>
			<div class="col-lg-2">
				<p id="addressId"></p>
			</div>
		</div>


		${ui.includeFragment("registrationapp","dataConsentInformation")}

		<button class="cancel close-consent-button">${ui.message("registrationapp.cancel")}</button>
		
	</section>

	<section id="paperConsentForm" style="display:none;">
		<!--div id="signature" style="background-color:#fff;hieght:150px;" class="col-lg-4">
	</div -->
		<h4>${ ui.message("registrationapp.generatePaperConsent") }</h4>
		<div id="paper-consent-form">
			<p>
				<h3 class="title">${ ui.message("registrationapp.dataConsent.form.1") }</h3>
			</p>
			<p>
				${ ui.message("registrationapp.patient.givenName.label") }:
				<b id="consent-form-given_name"> </b>, ${ ui.message("registrationapp.patient.middleName.label") }:
				<b id="consent-form-middle_name"> </b>, ${ ui.message("registrationapp.patient.familyName.label") }:
				<b id="consent-form-family_name"> </b>, ${ ui.message("registrationapp.patient.birthdate.label") }:
				<b id="consent-form-dob"> </b>, ${ ui.message("registrationapp.patient.tempIdentifier.label") }:
				<!-- <b id="consent-form-legacy_id"> </b>, ${ ui.message("registrationapp.registrationDate.label") }: -->
				<b id="consent-form-registration_date"> </b>, ${ ui.message("emr.gender") }:
				<b id="consent-form-gender"> </b>, ${ ui.message("registrationapp.patient.address") }:
				<b id="consent-form-address"> </b>.
			</p>
			<p>
				${ ui.message("registrationapp.dataConsent.form.2", "XXXX") }
				<ul style="list-style-type:square">
					<li> ${ ui.message("registrationapp.dataConsent.form.3") } </li>
					<li> ${ ui.message("registrationapp.dataConsent.form.4") } </li>
					<li> ${ ui.message("registrationapp.dataConsent.form.5") } </li>
					<li> ${ ui.message("registrationapp.dataConsent.form.6") } </li>
				</ul>
			</p>
			<p>
				<span class="title" style="margin-left: 5px">${ ui.message("registrationapp.dataConsent.form.7") }</span>
			</p>
			<p>
				<span class="title" style="margin-left: 5px">${ ui.message("registrationapp.dataConsent.form.signature") }</span>
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
			<button class="confirm" id="print-consent-button">${ ui.message("uicommons.print") }</button>
			<button class="cancel close-consent-button">${ui.message("registrationapp.cancel")}</button>
		</div>
		</div>
	</section>



	<section id="paperConsentFormAlreadySigned" style="display:none;">
		${ui.includeFragment("registrationapp","step/alreadySignedForm")}
		<button class="cancel close-consent-button">${ui.message("registrationapp.cancel")}</button>
	</section>