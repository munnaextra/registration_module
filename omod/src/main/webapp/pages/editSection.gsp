<%
    ui.decorateWith("appui", "standardEmrPage")
    ui.includeJavascript("uicommons", "handlebars/handlebars.min.js", Integer.MAX_VALUE - 1);
    ui.includeJavascript("uicommons", "navigator/validators.js", Integer.MAX_VALUE - 19)
    ui.includeJavascript("uicommons", "navigator/navigator.js", Integer.MAX_VALUE - 20)
    ui.includeJavascript("uicommons", "navigator/navigatorHandlers.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/navigatorModels.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/navigatorTemplates.js", Integer.MAX_VALUE - 21)
    ui.includeJavascript("uicommons", "navigator/exitHandlers.js", Integer.MAX_VALUE - 22);
    ui.includeJavascript("registrationapp", "consentPdfPrint.js")

    ui.includeCss("registrationapp", "editSection.css")
	
	
	
	if (civilStatus==null){
		civilStatus=""
	}


    def monthOptions = [ [label: ui.message("registrationapp.month.1"), value: 1],
                         [label: ui.message("registrationapp.month.2"), value: 2],
                         [label: ui.message("registrationapp.month.3"), value: 3],
                         [label: ui.message("registrationapp.month.4"), value: 4],
                         [label: ui.message("registrationapp.month.5"), value: 5],
                         [label: ui.message("registrationapp.month.6"), value: 6],
                         [label: ui.message("registrationapp.month.7"), value: 7],
                         [label: ui.message("registrationapp.month.8"), value: 8],
                         [label: ui.message("registrationapp.month.9"), value: 9],
                         [label: ui.message("registrationapp.month.10"), value: 10],
                         [label: ui.message("registrationapp.month.11"), value: 11],
                         [label: ui.message("registrationapp.month.12"), value: 12] ]
	
	
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

	
	
	
	

    Calendar cal = Calendar.getInstance()
    def maxAgeYear = cal.get(Calendar.YEAR)
    def minAgeYear = maxAgeYear - 120

    if (!returnUrl) {
        returnUrl = "/${contextPath}/coreapps/patientdashboard/patientDashboard.page?patientId=${patient.patientId}"
    }
%>
  ${ ui.includeFragment("uicommons", "validationMessages")}

  <script type="text/javascript">
    var NavigatorController;
    jQuery(function () {

      NavigatorController = KeyboardController();
      jq('#cancelSubmission').unbind(); // unbind the functionality built into the navigator to return to top of the form
      jq('#cancelSubmission').click(function (event) {
        window.location = '${ returnUrl }';
      })

      // disable submit button on submit
      jq('#registration-section-form').submit(function () {
        jq('#registration-submit').attr('disabled', 'disabled');
        jq('#registration-submit').addClass("disabled");
      })

      // clicking the save form link should have the same functionality as clicking on the confirmation section title (ie, jumps to confirmation)
      jq('#save-form').click(function () {
        NavigatorController.getSectionById("confirmation").title.click();
      })

    });
  </script>

  <script type="text/javascript">
    var breadcrumbs = [
      { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
      { label: "${ ui.escapeJs(ui.format(patient)) }", link: "${ ui.encodeHtml(returnUrl) }" },
      { label: "${ ui.message(section.label) }" }
    ];
  </script>


  <div id="content" class="container">
    <h2>
      ${ ui.message(section.label) }
    </h2>

    <div id="exit-form-container">
      <a id="save-form">
        <i class="icon-save small"></i>
        ${ ui.message("htmlformentryui.saveForm") }
      </a>
      <% if (returnUrl) { %>
        <a href="${ ui.escapeAttribute(returnUrl) }">
          <i class="icon-signout small"></i>
          ${ ui.message("htmlformentryui.exitForm") }
        </a>
        <% } %>
    </div>

    <form id="registration-section-form" class="simple-form-ui ${section.skipConfirmation ? 'skip-confirmation-section' : ''}"
      method="POST" action="/${contextPath}/registrationapp/editSection.page?patientId=${patient.patientId}&returnUrl=${ ui.urlEncode(returnUrl) }&appId=${app.id}&sectionId=${ ui.encodeHtml(section.id) }">
      <!-- read configurable sections from the json config file-->
      <section id="demographics" class="non-collapsible">
        <span id="demographics_label" class="title">HSU General Data</span>

        <!-- hardcoded name, gender, and birthdate are added for the demographics section -->
        <fieldset id="demographics-name">

          <legend>${ui.message("registrationapp.patient.name.label")}</legend>
          <div>
            <h3>${ui.message("registrationapp.patient.name.question")}</h3>

            <% nameTemplate.lines.each { line ->
                                    // go through each line in the template and find the first name token; assumption is there is only one name token per line
                                    def name = line.find({it['isToken'] == 'IS_NAME_TOKEN'})['codeName'];
                                    def initialNameFieldValue = ""
                                    if(patient.personName && patient.personName[name]){
                                        initialNameFieldValue = patient.personName[name]
                                    }
                                %>

              ${ ui.includeFragment("registrationapp", "field/personName", [ label: ui.message(nameTemplate.nameMappings[name]), size:
              nameTemplate.sizeMappings[name], formFieldName: name, dataItems: 4, left: true, initialValue: initialNameFieldValue,
              classes: [""] ])}

              <% } %>
          </div>


          <input type="hidden" name="preferred" value="true" />
        </fieldset>


        <fieldset id="demographics-birthdate" class="multiple-input-date date-required no-future-date">
          <legend id="birthdateLabel">${ui.message("registrationapp.patient.birthdate.label")}</legend>
          <h3>${ui.message("registrationapp.patient.birthdate.question")}</h3>
          ${ ui.includeFragment("uicommons", "field/multipleInputDate", [ label: "", formFieldName: "birthdate", left: true, showEstimated:
          true, estimated: patient.birthdateEstimated, initialValue: patient.birthdate, minYear: minAgeYear, maxYear: maxAgeYear
          ])}


        </fieldset>

        <fieldset id="demographics-gender">
          <legend id="genderLabel">${ ui.message("emr.gender") }</legend>
          <h3>${ui.message("registrationapp.patient.gender.question")}</h3>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "gender", formFieldName: "gender", options: genderOptions, classes:
          ["required"], initialValue: patient.gender, hideEmptyLabel: true, expanded: true ])}
          <!-- we "hide" the unknown flag here since gender is the only field not hidden for an unknown patient -->
          <input id="demographics-unknown" type="hidden" name="unknown" value="false" />
        </fieldset>

        <fieldset id="demographics-civilStatus">
          <legend id="birthdateLabel">${ui.message("Civil Status")}</legend>
          <h3>${ui.message("What is your Civil Status")}</h3>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "civilStatus", formFieldName: "civilStatus", options: civilStatusOptions,
          classes: ["required"], initialValue: civilStatus, hideEmptyLabel: true, expanded: true ])}
        </fieldset>



        <fieldset id="demographics-address">
          <legend id="genderLabel">Address</legend>
          <h3>${ui.message("registrationapp.patient.gender.question")}</h3>
          ${ ui.includeFragment("uicommons", "field/address", [ id: "address" ])}
          <!-- we "hide" the unknown flag here since gender is the only field not hidden for an unknown patient -->
          <input id="demographics-unknown" type="hidden" name="unknown" value="false" />
        </fieldset>

        <fieldset id="demographics-nationality">
          <legend id="birthdateLabel">${ui.message("Nationality")}</legend>
          <h3>${ui.message("Nationality")}</h3>
          ${ ui.includeFragment("uicommons", "field/text", [ id: "nationality", formFieldName: "nationality", classes: ["required"],
          initialValue: nationality, label:"", hideEmptyLabel: true, expanded: true ])}
        </fieldset>



        <fieldset id="demographics-email">
          <legend id="birthdateLabel">${ui.message("Email")}</legend>
          ${ ui.includeFragment("uicommons", "field/text", [ id: "email", formFieldName: "email", initialValue: email, label:"Email",
          hideEmptyLabel: true, expanded: true ])}

        </fieldset>

        <fieldset id="demographics-languages">
          <legend id="birthdateLabel">${ui.message("Languages Spoken")}</legend>
          <h3>${ui.message("Languages Spoken")}</h3>
          ${ ui.includeFragment("uicommons", "field/text", [ id: "email", formFieldName: "languages", initialValue: languagesSpoken,
          label:"", hideEmptyLabel: true, expanded: true ])}

        </fieldset>




        <fieldset id="demographics-legalBasis">
          <legend id="legalBasis">${ui.message("Legal Basis")}</legend>
          <h3>${ui.message("Legal Basis")}</h3>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "email", formFieldName: "legalBasis", initialValue: "", options:
          legalOptions, label:"", hideEmptyLabel: true, expanded: true ])}

        </fieldset>


        <fieldset id="demographics-emergencyContact">
          <legend id="emergencyContact">${ui.message("Emergency Contact")}</legend>
          <h3>${ui.message("Emergency Contact")}</h3>
          ${ ui.includeFragment("uicommons", "field/contact", [ id: "emergencyContact", relationshipOptions: relationshipOptions, ])}


        </fieldset>


        <fieldset id="demographics-emergencyContact">
          <legend id="backupContact">${ui.message("Backup Contact")}</legend>
          <h3>${ui.message("Backup Contact")}</h3>
          ${ ui.includeFragment("uicommons", "field/contact", [ id: "backupContact", relationshipOptions: relationshipOptions, ])}


        </fieldset>



        <fieldset id="demographics-benfPopType">
          <legend id="benfPoplationType">${ui.message("Beneficiary Population Type")}</legend>
          <h3>${ui.message("Beneficiary Population Type")}</h3>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "benfPoplationType", formFieldName: "benfPoplationType", initialValue:
          benfType, options: benfPopType, label:"", hideEmptyLabel: true, expanded: true ])}

        </fieldset>




        <!-- allow customization of additional question in the patient identification section, if it is included -->
      </section>

      <section id="registration-info" class="non-collapsible">
        <span class="title">HSU PRP Center-Specific Data</span>


        <fieldset id="demographics-legacyID">
          <legend id="birthdateLabel">${ui.message("Legacy ID")}</legend>
          <h3>${ui.message("Legacy ID")}</h3>
          ${ ui.includeFragment("uicommons", "field/text", [ id: "legacyId", formFieldName: "legacyId", initialValue: legacyId, label:"",
          hideEmptyLabel: true, expanded: true ])}

        </fieldset>



        <fieldset id="demographics-occupation">
          <h3>${ui.message("Occupation")}</h3>
          <legend id="occupation">${ui.message("Occupation")}</legend>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "occupation", formFieldName: "occupation", initialValue: occupation,
          options: occList, label:"", hideEmptyLabel: true, expanded: true ])}

        </fieldset>

        <fieldset id="demographics-occupation">
          <h3>${ui.message("How did you know the PRC ?")}</h3>
          <legend id="hdykList">${ui.message("How did you know")}</legend>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "hdykList", formFieldName: "hdyk", initialValue: hdyk, options:
          hdykList, label:"", hideEmptyLabel: true, expanded: true ])}

        </fieldset>

        <fieldset id="demographics-status">
          <h3>${ui.message("Status")}</h3>
          <legend id="occupation">${ui.message("Status")}</legend>
          ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "occupation", formFieldName: "status", initialValue: status, options:
          statusList, label:"", hideEmptyLabel: true, expanded: true ])}

        </fieldset>

      </section>








      <div id="confirmation">
        <span class="title">${ui.message("registrationapp.patient.confirm.label")}</span>
        <div class="before-dataCanvas"></div>
        <div id="dataCanvas"></div>
        <div class="after-data-canvas"></div>
        <div id="confirmationQuestion">
          ${ui.message("registrationapp.confirm")}
          <p style="display: inline">
            <button id="registration-submit" type="submit" class="submitButton confirm right">
              ${ui.message("registrationapp.patient.confirm.label")}
            </button>
          </p>
          <p style="display: inline">
            <button id="cancelSubmission" class="cancel" type="button">
              ${ui.message("registrationapp.cancel")}
            </button>
          </p>
        </div>
      </div>
    </form>
  </div>