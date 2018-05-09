package org.openmrs.module.registrationapp.fragment.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class DownloadFileFragmentController {

	private static final String REFERRAL_FOLDER_NAME = "reference_documents";
	private static final int DEFAULT_BUFFER_SIZE = 102400;

	private final Log log = LogFactory
			.getLog(DownloadFileFragmentController.class);
	
	public void downloadFile(HttpServletRequest req, HttpServletResponse response) {

		try {

			File document = null;
			BufferedInputStream input = null;
			BufferedOutputStream output = null;
			
			/*
			 * Lilian
			 * FIXME: document should be retrieved from the request. Currently always null. => Bug to fix
			 */
			if ( !document.exists()) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}

			MimetypesFileTypeMap mimetypesFileTypeMap = new MimetypesFileTypeMap();
			String contentType = mimetypesFileTypeMap.getContentType(document);

			/*
			 * String contentType =
			 * getServletContext().getMimeType(image.getName()); if (contentType
			 * == null || !contentType.startsWith("image")) {
			 * response.sendError(HttpServletResponse.SC_NOT_FOUND); return; }
			 */

			response.reset();
			response.setBufferSize(DEFAULT_BUFFER_SIZE);
			response.setContentType(contentType);
			response.setHeader("Content-Length", String.valueOf(document.length()));
			response.setHeader("Content-Disposition", "inline; filename=\"" + document.getName() + "\"");
			input = new BufferedInputStream(new FileInputStream(document), DEFAULT_BUFFER_SIZE);
			output = new BufferedOutputStream(response.getOutputStream(), DEFAULT_BUFFER_SIZE);

			byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
			int length;
			while ((length = input.read(buffer)) > 0) {
				output.write(buffer, 0, length);

			}
			input.close();
		} catch (IOException exp) {
			log.error("downloading file",exp);
		}

	}

}
