package org.openmrs.module.registrationapp.fragment.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.openmrs.ui.framework.SimpleObject;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class UploadDocumentFragmentController {

	public SimpleObject uploadFile(@RequestParam("patientName") String patientName, HttpServletRequest request) {
		SimpleObject so = new SimpleObject();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

		Iterator<String> itrator = multipartRequest.getFileNames();
		List<MultipartFile> visitDocList = multipartRequest.getFiles("file");
		for (Iterator iterator = visitDocList.iterator(); iterator.hasNext();) {
			MultipartFile multipartFile = (MultipartFile) iterator.next();
			long fileSize = multipartFile.getSize();
			String fileName = multipartFile.getOriginalFilename();
			int i = fileName.lastIndexOf('.');
			if (fileSize < 10 * 1024 * 1024) {
				try {
					writeFile(multipartFile, patientName, null);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}

		return so;

	}

	public void writeFile(MultipartFile multiPart, String filePrefix, String encId) {
		if (multiPart != null) {
			try {
			String filePath = "/home/prateekt/Documents/data/images/";
			String fileName = multiPart.getOriginalFilename();
			
			String date = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
			String nameWithoutExtension=filePrefix+"-"+fileName.substring(0,fileName.lastIndexOf('.'))+"-"+date;
			String extension=fileName.substring(fileName.lastIndexOf('.')+1);
			fileName = date + "-" + fileName;
			File file = new File(filePath, nameWithoutExtension+"."+extension);
			filePath = file.getAbsolutePath();
			FileOutputStream fileOut = null;

			fileOut = new FileOutputStream(filePath);
			IOUtils.copy(multiPart.getInputStream(), fileOut);
			fileOut.close();
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

}
