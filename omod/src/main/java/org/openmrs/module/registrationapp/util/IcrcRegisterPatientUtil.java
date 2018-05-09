package org.openmrs.module.registrationapp.util;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

import org.openmrs.Patient;
import org.openmrs.Person;
import org.openmrs.PersonAttribute;
import org.openmrs.PersonAttributeType;
import org.openmrs.api.PersonService;
import org.openmrs.api.context.Context;
import org.openmrs.ui.framework.page.PageModel;

public class IcrcRegisterPatientUtil {

	public static void updatePatient(HttpServletRequest request, PersonService personService, Patient patient, Boolean unknown) {

		addICRCSpecificPatientAttributes(request, patient);

		if (unknown != null && !unknown) {
			generatePermId(patient, personService);
		}

		personService.savePerson(patient);
	}

	public static void generatePermId(Patient patient, PersonService personService) {
		PersonAttributeType attrType = personService.getPersonAttributeType(25);
		if (attrType == null) {
			return;
		}
		PersonAttribute attr = new PersonAttribute();
		attr.setAttributeType(attrType);
		attr.setValue(patient.getPatientIdentifier().getIdentifier()
				.replace("TEMP", "PERM"));
		attr.setDateCreated(new Date());
		patient.addAttribute(attr);
	}

	public static void addICRCSpecificModelAttributes(PageModel model, Patient patient) {

		model.addAttribute("civilStatus", getAttributeValue(patient, 5));
		model.addAttribute("nationality", getAttributeValue(patient, 3));
		model.addAttribute("email", getAttributeValue(patient, 11));
		model.addAttribute("languagesSpoken", getAttributeValue(patient, 12));
		model.addAttribute("legalBasis", getAttributeValue(patient, 13));
		model.addAttribute("emergencyContactRelationship", getAttributeValue(patient, 14));
		model.addAttribute("emergencyContactName", getAttributeValue(patient, 15));
		model.addAttribute("emergencyContactPhone", getAttributeValue(patient, 16));
		model.addAttribute("backupContactRelationship", getAttributeValue(patient, 17));
		model.addAttribute("backupContactName", getAttributeValue(patient, 18));
		model.addAttribute("backupContactPhone", getAttributeValue(patient, 19));
		model.addAttribute("benfType", getAttributeValue(patient, 20));

		model.addAttribute("legacyId", getAttributeValue(patient, 21));
		model.addAttribute("occupation", getAttributeValue(patient, 22));
		model.addAttribute("hdyk", getAttributeValue(patient, 23));
		model.addAttribute("status", getAttributeValue(patient, 24));

	}

	private static String getAttributeValue(Patient patient,Integer typeId){
		PersonAttribute attr=patient.getAttribute(typeId);
		return attr == null ? "" : attr.getValue();
	}

	public static void addICRCSpecificPatientAttributes(HttpServletRequest request, Patient patient) {
		/*
		 * ICRC Customization 
		 *
		 * Adding attributes to person
		 */
		// Adding Civil Status
		addPersonAttribute(patient, "civilStatus", 5, request);
		// Adding Attribute nationality under Attribute Type: Citizenship
		addPersonAttribute(patient, "nationality", 3, request);
		// Adding Email
		addPersonAttribute(patient, "email", 11, request);
		// Adding Languages Spoken
		addPersonAttribute(patient, "languages", 12, request);
		// Legal Basis
		addPersonAttribute(patient, "legalBasis", 13, request);
		// Relationship
		addPersonAttribute(patient, "emergencyContact-relationship", 14,
				request);// Relationship
		addPersonAttribute(patient, "emergencyContact-name", 15, request);// Name
		addPersonAttribute(patient, "emergencyContact-phone", 16, request);// Phone
		// Backup contact
		addPersonAttribute(patient, "backupContact-name", 17, request);// Name
		addPersonAttribute(patient, "backupContact-relationship", 18,
				request);// Relationship
		addPersonAttribute(patient, "backupContact-phone", 19, request);// Phone
		// Beneficiary Type
		addPersonAttribute(patient, "benfPopType", 20, request);
		// Legacy Id
		addPersonAttribute(patient, "legacyId", 21, request);
		// Occupation
		addPersonAttribute(patient, "occupation", 22, request);
		// How did you know ??
		addPersonAttribute(patient, "hdyk", 23, request);
		// Status
		addPersonAttribute(patient, "status", 24, request);
	}

	private static void addPersonAttribute(Patient patient, String requestParam,
			int attributeTypeId, HttpServletRequest request) {

		if(request.getParameter(requestParam)!= null){
			PersonAttributeType attrType = Context.getPersonService()
					.getPersonAttributeType(attributeTypeId);
			PersonAttribute attr = new PersonAttribute();
			attr.setAttributeType(attrType);
			attr.setValue(request.getParameter(requestParam));
			attr.setDateCreated(new Date());
			patient.addAttribute(attr);
		}

	}
}
