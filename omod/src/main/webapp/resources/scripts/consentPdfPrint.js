jq = jQuery;
jsPDF = jspdf;

function formatAddress() {
  var address = "";
  if (jq("#country-field").val()) {
    address += jq("#country-field").val();
  }
  if (jq("#adminLevel1-field").val()) {
    if (address !== "") {
      address += ", ";
    }
    address += jq("#adminLevel1-field").val();
  }
  if (jq("#adminLevel2-field").val()) {
    if (address !== "") {
      address += ", ";
    }
    address += jq("#adminLevel2-field").val();
  }
  if (jq("#adminLevel3-field").val()) {
    if (address !== "") {
      address += ", ";
    }
    address += jq("#adminLevel3-field").val();
  }
  if (jq("#adminLevel4-field").val()) {
    if (address !== "") {
      address += ", ";
    }
    address += jq("#adminLevel4-field").val();
  }
  if (jq("#street-field").val()) {
    if (address !== "") {
      address += ", ";
    }
    address += jq("#street-field").val();
  }
  return address;
}

// a handy function to print only selected element. Should be extracted for use elsewhere too.
function printMe(element) {
  var doc = new jsPDF();
  var elementHandler = {
    "#ignorePDF": function(element, renderer) {
      return true;
    }
  };
  var source = window.document.getElementById(element);
  doc.fromHTML(source, 15, 15, {
    width: 180,
    elementHandlers: elementHandler
  });

  var string = doc.output("datauristring");
  var iframe =
    "<iframe width='100%' height='100%' src='" + string + "'></iframe>";
  var newWindow = window.open();
  newWindow.document.open();
  newWindow.document.write(iframe);
  newWindow.document.close();

  doc.save(jq("input[name='familyName']").val() + ".consent.pdf");
}

function fillConsentForm() {
  function getLang() {
    if (navigator.languages != undefined) return navigator.languages[0];
    else return navigator.language;
  }

  function formatDate(date) {
    var options = { year: "numeric", month: "long", day: "numeric" };
    var locale = getLang();
    return date.toLocaleDateString(locale, options);
  }

  // setting up the actions for the dialog
  function initpaperConsentDialog() {
    // Populates the consent form with:
    // given name
    jq("#consent-form-given_name").text(jq("input[name='givenName']").val());
    // middle name
    jq("#consent-form-middle_name").text(jq("input[name='middleName']").val());
    // family name
    jq("#consent-form-family_name").text(jq("input[name='familyName']").val());
    // dob
    jq("#consent-form-dob").text(jq("#birthDate-display").val());
    // legacy id
    jq("#consent-form-legacy_id").text(jq("#legacyId-field").val());
    // registration date
    jq("#consent-form-registration_date").text(formatDate(new Date()));
    // gender
    jq("#consent-form-gender").text(
      jq("select[name='gender']")
        .find(":selected")
        .text()
    );
    // address
    jq("#consent-form-address").text(formatAddress());
  }

  // do the magic
  initpaperConsentDialog();
}

function fillTrConsentForm() {
  // setting up the actions for the dialog
  function initpaperConsentDialog() {
    //TODO: fetch these id they don't exist when the initial assessment workflow is done
    // Populates the consent form with:
    // given name
    jq("#trConsent-form-given_name").text(jq("input[name='givenName']").val());
    // middle name
    jq("#trConsent-form-middle_name").text(
      jq("input[name='middleName']").val()
    );
    // family name
    jq("#trConsent-form-family_name").text(
      jq("input[name='familyName']").val()
    );
    // hsu id TODO: Fix this to show HSU ID
    jq("#trConsent-form-hsu_id").text(jq("#legacyId-field").val());
  }

  // do the magic
  initpaperConsentDialog();
}
