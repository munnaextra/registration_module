<script>
	jq(document).ready(function () {
		jq("#next-step-5").hide();
		jq("#confirmLegalBasis").click(function (e) {
			e.preventDefault();
			jq("#next-step-5").click();
		});
	});

	jq("select[name='legalBasis']").change(function (event) {
		jq(".consentButtons").attr(
			"disabled",
			jq(event.currentTarget)
				.find(":selected")
				.text() !== "Consent"
		);
	});
</script>

<button id="confirmLegalBasis" class="btn btn-success">${ui.message("registrationapp.person.legal.confirm")}</button>