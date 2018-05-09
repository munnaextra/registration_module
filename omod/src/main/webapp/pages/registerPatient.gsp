<%
if (sessionContext.authenticated && !sessionContext.currentProvider) {
throw new IllegalStateException("Logged-in user is not a Provider")
}
ui.decorateWith("appui", "standardEmrPage")
ui.includeJavascript("uicommons", "handlebars/handlebars.min.js", Integer.MAX_VALUE - 1);
ui.includeJavascript("uicommons", "navigator/validators.js", Integer.MAX_VALUE - 19)
ui.includeJavascript("uicommons", "navigator/navigator.js", Integer.MAX_VALUE - 20)
ui.includeJavascript("uicommons", "navigator/navigatorHandlers.js", Integer.MAX_VALUE - 21)
ui.includeJavascript("uicommons", "navigator/navigatorModels.js", Integer.MAX_VALUE - 21)
ui.includeJavascript("uicommons", "navigator/navigatorTemplates.js", Integer.MAX_VALUE - 21)
ui.includeJavascript("uicommons", "navigator/exitHandlers.js", Integer.MAX_VALUE - 22);
ui.includeJavascript("registrationapp", "registerPatient.js");
ui.includeCss("registrationapp","registerPatient.css");
ui.includeCss("uicommons", "datatables/dataTables_jui.css");
ui.includeJavascript("uicommons", "datatables/jquery.dataTables.min.js");
ui.includeJavascript("uicommons", "jquery-1.12.4.js");

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
def minRegistrationAgeYear= maxAgeYear - 15 // do not allow backlog registrations older than 15 years

def breadcrumbMiddle = breadcrumbOverride ?: '';

def patientDashboardLink = patientDashboardLink ? ("/${contextPath}/" + patientDashboardLink) : ui.pageLink("coreapps", "clinicianfacing/patient")
def identifierSectionFound = false
%>

  <% if(includeFragments){
includeFragments.each{ %>
    ${ ui.includeFragment(it.extensionParams.provider, it.extensionParams.fragment)}
    <%   }
} %>

      <!-- used within registerPatient.js -->
      <%= ui.includeFragment("appui", "messages", [ codes: [
'emr.gender.M',
'emr.gender.F',
'registrationapp.person.gender.other'
].flatten()
]) %>

        ${ ui.includeFragment("uicommons", "validationMessages")}

        <style type="text/css">
          .matchingPatientContainer .container {
            overflow: hidden;
          }

          .matchingPatientContainer .container div {
            margin: 5px 10px;
          }

          .matchingPatientContainer .container .name {
            font-size: 25px;
            display: inline-block;
          }

          .matchingPatientContainer .container .info {
            font-size: 15px;
            display: inline-block;
          }

          .matchingPatientContainer .container .identifiers {
            font-size: 15px;
            display: inline-block;
            min-width: 600px;
          }

          .matchingPatientContainer .container .identifiers .idName {
            font-size: 15px;
            font-weight: bold;
          }

          .matchingPatientContainer .container .identifiers .idValue {
            font-size: 15px;
            margin: 0 20px 0 0;
          }

          .scroll {
            width: 750px;
            overflow-x: scroll;
            height: 150px;
          }

          table {
            border-collapse: collapse;
            border-radius: 5px;
          }

          th {
            border-bottom: 1px solid #fff;
            border-right: 1px solid #fff;
            border-left: 1px solid #fff;
            padding: 1px 1px 0;

          }

          td {



            align: 'right';
            border-bottom: 1px solid #fff;
            border-right: 1px solid #fff;

            padding: 1px 1px 0
          }

          .fixed {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
          }
        </style>
        <script type="text/javascript">


          var breadcrumbs = _.compact(_.flatten([
            { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
            ${ breadcrumbMiddle },
            { label: "${ ui.message("registrationapp.registration.label") }", link: "${ ui.pageLink("registrationapp", "registerPatient") }" }
          ]));


          jq(document).ready(function () {



            jq("#registerAnother").click(function () {
              jq("#redirectHere").val("true");
              jq("#registration").submit();
            });
          });






          var testFormStructure = "${formStructure}";
          var patientDashboardLink = '${patientDashboardLink}';
          var appId = '${ui.escapeJs(appId)}';

          // hack to create the sections variable used by the unknown patient handler in registerPatient.js
          var sections = [];
<% formStructure.sections.each {
            structure ->
              def section = structure.value;  %>
                sections.push('${section.id}');
<% } %>




        </script>

        <div id="validation-errors" class="note-container" style="display: none">
          <div class="note error">
            <div id="validation-errors-content" class="text">

            </div>
          </div>
        </div>

        <div id="content" class="container">
          <h2>
            ${ ui.message("registrationapp.registration.label") }
          </h2>

          <div id="similarPatients" class="highlighted" style="display: none;">
            <div class="left" style="padding: 6px">
              <span id="similarPatientsCount"></span> ${ ui.message("registrationapp.similarPatientsFound") }</div>
            <button class="right" id="reviewSimilarPatientsButton">${ ui.message("registrationapp.reviewSimilarPatients.button") }</button>
            <div class="clear"></div>
          </div>

          <div id="similarPatientsSlideView" style="display: none;">
            <ul id="similarPatientsSelect" class="matchingPatientContainer select" style="width: auto;">

            </ul>
          </div>

          <div id="biometricPatients" class="highlighted" style="display: none;">
            <div class="left" style="padding: 6px">
              <span id="biometricPatientsCount"></span> ${ ui.message("registrationapp.biometrics.matchingPatientsFound") }</div>
            <button class="right" id="reviewBiometricPatientsButton">${ ui.message("registrationapp.reviewSimilarPatients.button") }</button>
            <div class="clear"></div>
          </div>

          <div id="biometricPatientsSlideView" style="display: none;">
            <ul id="biometricPatientsSelect" class="matchingPatientContainer select" style="width: auto;">

            </ul>
          </div>

          <div id="matchedPatientTemplates" style="display:none;">
            <div class="container" style="border-color: #00463f; border-style: solid; border-width:2px; margin-bottom: 10px;">
              <div class="name"></div>
              <div class="info"></div>
              <div class="identifiers">
                <span class="idName idNameTemplate"></span>
                <span class="idValue idValueTemplate"></span>
              </div>
            </div>
            <button class="local_button" style="float:right; margin:10px; padding: 2px 8px" onclick="location.href='/openmrs-standalone/coreapps/clinicianfacing/patient.page?patientId=7'">
              ${ui.message("registrationapp.open")}
            </button>
            <button class="mpi_button" style="float:right; margin:10px; padding: 2px 8px" onclick="location.href='/execute_script_which_will_request_service_to_import_patient_from_mpi_to_local_DB_and_redirect_to_patient_info'">
              ${ui.message("registrationapp.importAndOpen")}
            </button>
          </div>

          <form class="simple-form-ui" id="registration" method="POST">

            <% if (includeRegistrationDateSection) { %>
              <section id="registration-info" class="non-collapsible">
                <span class="title">${ui.message("registrationapp.registrationDate.label")}</span>

                <fieldset id="registration-date" class="multiple-input-date no-future-date">
                  <legend id="registrationDateLabel">${ui.message("registrationapp.registrationDate.label")}</legend>
                  <h3>${ui.message("registrationapp.registrationDate.question")}</h3>

                  <p>
                    <input id="checkbox-enable-registration-date" type="checkbox" checked/>
                    <label for="checkbox-enable-registration-date">${ui.message("registrationapp.registrationDate.today")}</label>
                  </p>

                  ${ ui.includeFragment("uicommons", "field/multipleInputDate", [ label: "", formFieldName: "registrationDate", left: true,
                  classes: ['required'], showEstimated: false, initialValue: "", minYear: minRegistrationAgeYear, maxYear:
                  maxAgeYear, ])}
                </fieldset>
              </section>
              <% } %>

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



                    <% if (allowUnknownPatients) { %>

                      <!-- TODO: fix this horrible method of making this line up properly -->
                      <div style="display:inline-block">
                        <!-- note that we are deliberately not including this in a p tag because we don't want the handler to pick it up as an actual field -->
                        <nobr>
                          <input id="checkbox-unknown-patient" name="unknown" type="checkbox" />
                          <label for="checkbox-unknown-patient">${ui.message("registrationapp.patient.demographics.unknown")}</label>
                        </nobr>
                      </div>

                      <% } %>



                        <input type="hidden" name="preferred" value="true" />
                  </fieldset>


                  <fieldset id="demographics-birthdate" class="multiple-input-date date-required no-future-date">
                    <legend id="birthdateLabel">${ui.message("registrationapp.patient.birthdate.label")}</legend>
                    <h3>${ui.message("registrationapp.patient.birthdate.question")}</h3>
                    ${ ui.includeFragment("uicommons", "field/multipleInputDate", [ label: "", formFieldName: "birthdate", left: true, showEstimated:
                    true, estimated: patient.birthdateEstimated, initialValue: patient.birthdate, minYear: minAgeYear, maxYear:
                    maxAgeYear ])}


                  </fieldset>

                  <fieldset id="demographics-gender">
                    <legend id="genderLabel">${ ui.message("emr.gender") }</legend>
                    <h3>${ui.message("registrationapp.patient.gender.question")}</h3>
                    ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "gender", formFieldName: "gender", options: genderOptions, classes:
                    ["required"], initialValue: "", hideEmptyLabel: true, expanded: true ])}
                    <!-- we "hide" the unknown flag here since gender is the only field not hidden for an unknown patient -->
                    <input id="demographics-unknown" type="hidden" name="unknown" value="false" />
                  </fieldset>

                  <fieldset id="demographics-civilStatus">
                    <legend id="birthdateLabel">${ui.message("Civil Status")}</legend>
                    <h3>${ui.message("What is your Civil Status")}</h3>
                    ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "civilStatus", formFieldName: "civilStatus", options: civilStatusOptions,
                    classes: ["required"], initialValue: "", hideEmptyLabel: true, expanded: true ])}
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
                    initialValue: "", label:"", hideEmptyLabel: true, expanded: true ])}
                  </fieldset>



                  <fieldset id="demographics-email">
                    <legend id="birthdateLabel">${ui.message("Email")}</legend>
                    ${ ui.includeFragment("uicommons", "field/text", [ id: "email", formFieldName: "email", initialValue:"", label:"Email", hideEmptyLabel:
                    true, expanded: true ])}

                  </fieldset>

                  <fieldset id="demographics-languages">
                    <legend id="birthdateLabel">${ui.message("Languages Spoken")}</legend>
                    <h3>${ui.message("Languages Spoken")}</h3>
                    ${ ui.includeFragment("uicommons", "field/text", [ id: "languages", formFieldName: "languages", initialValue: "", label:"",
                    hideEmptyLabel: true, expanded: true ])}

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
                    "", options: benfPopType, label:"", hideEmptyLabel: true, expanded: true ])}

                  </fieldset>




                  <!-- allow customization of additional question in the patient identification section, if it is included -->
                </section>

                <section id="registration-info" class="non-collapsible">
                  <span class="title">HSU PRP Center-Specific Data</span>


                  <fieldset id="demographics-legacyID">
                    <legend id="birthdateLabel">${ui.message("Legacy ID")}</legend>
                    <h3>${ui.message("Legacy ID")}</h3>
                    ${ ui.includeFragment("uicommons", "field/text", [ id: "legacyId", formFieldName: "legacyID", initialValue: "", label:"",
                    hideEmptyLabel: true, expanded: true ])}

                  </fieldset>



                  <fieldset id="demographics-occupation">
                    <h3>${ui.message("Occupation")}</h3>
                    <legend id="occupation">${ui.message("Occupation")}</legend>
                    ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "occupation", formFieldName: "occupation", initialValue: "", options:
                    occList, label:"", hideEmptyLabel: true, expanded: true ])}

                  </fieldset>

                  <fieldset id="demographics-hdyk">
                    <h3>${ui.message("How did you know the PRC ?")}</h3>
                    <legend id="hdykList">${ui.message("How did you know")}</legend>
                    ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "hdykList", formFieldName: "hdyk", initialValue: "", options:
                    hdykList, label:"", hideEmptyLabel: true, expanded: true ])}

                  </fieldset>

                  <fieldset id="demographics-status">
                    <h3>${ui.message("Status")}</h3>
                    <legend id="occupation">${ui.message("Status")}</legend>
                    ${ ui.includeFragment("uicommons", "field/dropDown", [ id: "occupation", formFieldName: "status", initialValue: "", options:
                    statusList, label:"", hideEmptyLabel: true, expanded: true ])}

                  </fieldset>

                </section>






                <% if (allowManualIdentifier && !identifierSectionFound) { %>
                  <section id="patient-identification-section" class="non-collapsible">
                    <span class="title">${ui.message("registrationapp.patient.identifiers.label")}</span>

                    ${ ui.includeFragment("registrationapp", "field/allowManualIdentifier", [ identifierTypeName: ui.format(primaryIdentifierType)
                    ])}
                  </section>
                  <% } %>

                    <div id="confirmation">
                      <span id="confirmation_label" class="title">${ui.message("registrationapp.patient.confirm.label")}</span>
                      <div class="before-dataCanvas"></div>
                      <div id="dataCanvas"></div>
                      <div class="after-registerPatientdata-canvas"></div>
                      <div id="exact-matches" style="display: none; margin-bottom: 20px">
                        <span class="field-error">${ui.message("registrationapp.exactPatientFound")}</span>
                        <ul id="exactPatientsSelect" class="select"></ul>
                      </div>
                      <div id="consentQuestion" style="margin-bottom: 20px">
                        <div>
                          <span id="consent_label" class="title" style="margin-left: 5px">${ ui.message("registrationapp.consent") }</span>
                          <p style="display: inline">
                            <input id="generatePaperConsent" class="task right consentButtons" style="margin-right: 10px" type="button" value="${ui.message("
                              registrationapp.generatePaperConsent ")}" />
                          </p>
                          <p style="display: inline">
                            <input id="generateDigitalConsent" class="task right consentButtons" style="margin-right: 10px" type="button" value="${ui.message("
                              registrationapp.generateDigitalConsent ")}" />
                          </p>
                        </div>

                        <div>
                          <p style="display: inline">
                            <input id="attachPaperConsent" class="task right consentButtons" style="margin-right: 10px" type="button" value="${ui.message("
                              registrationapp.attachPaperConsent ")}" />
                          </p>
                        </div>
                      </div>

                      <div id="confirmationQuestion">
                        ${ ui.message("registrationapp.confirm") }
                        <input id="registerAnother" type="button" class="submitButton confirm right submitBtn" value="${ui.message(" registrationapp.patient.saveAndRegister.label
                          ")}" />
                        <!--     <input id="registerAnother" type="button" class="submitButton confirm right submitBtn" value="${ui.message("registrationapp.patient.saveAndRegister.label")}" />  -->
                        <p style="display: inline">
                          <!-- TFS 82775 -->
                          <input id="submit" type="button" class="submitButton confirm right submitBtn" value="${ui.message(" registrationapp.patient.scheduleAssessment.label
                            ")}" />
                        </p>


                        <input type="text" id="redirectHere" name="redirectHere" style="display:none;">
                        <p style="display: inline">
                          <input id="cancelSubmission" class="cancel" type="button" value="${ui.message(" registrationapp.cancel ")}" />
                        </p>
                      </div>
                    </div>
          </form>
        </div>
        <!-- TFS 82775 -->
        <div id="submitionDialogueBox" class="dialog">
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
                  <th>${ui.message("registrationapp.patient.birthdate.label")}</th>
                  <th>${ui.message("registrationapp.patient.address")}</th>
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