package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.domain.AttachVO;
import com.spring.mapper.ShopMapper;
import com.spring.service.ShopService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class AjaxUploadController {
	@Autowired
	private ShopService service;

	//@ResponseBody
	@PostMapping(value="/uploadAjax",produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachVO>> uploadAjaxFormPost(MultipartFile[] uploadFile) {
		log.info("upload Ajax ��û");
		String uploadFolder = "d:\\upload\\";
		String uploadFileName = "";
		
		String uploadFolderPath = "images\\";
		File uploadPath = new File(uploadFolder,uploadFolderPath);  //uploadFolder ��ο� uploadFolderPath�� �̸��� ���� ����
		
		if(!uploadPath.exists()) { //�̹� ����������� �ʴٸ�
			uploadPath.mkdirs(); //uploadFolderPath�� �̸����� ���� ����
		}
		
		// ������� �۾� = d����̺��� upload������ ��������
		
		
		
		//��û���� ���� �ޱ� ����
		List<AttachVO> attachList = new ArrayList<AttachVO>();
		for(MultipartFile f:uploadFile) { //�� VO �����۾�
			log.info("-------------------------------");
			log.info("upload File Name : "+f.getOriginalFilename());
			log.info("upload file Size : "+f.getSize()+"Byte");
			
			//������ �ߺ��� �����ϱ� ���ؼ�, ������ ����
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+f.getOriginalFilename(); //������ �̸� (uuid��+���ϸ�) �غ�
			
			AttachVO attach = new AttachVO(); // �������ϵ�  ���� ���ϸ� , ������� , uuid�� ����
			attach.setFileName(f.getOriginalFilename());
			attach.setUploadPath(uploadFolderPath);
			attach.setUuid(uuid.toString());
			
			
			try {
				Path saveFile = Paths.get(uploadPath.getPath(),uploadFileName);   // ���� ������ ���ϵ��� uploadPath(��¥�� ���� �����)�� ������ �̸����� �����غ�

				f.transferTo(saveFile); // �� ���ϵ� ����
				attachList.add(attach);  //����Ʈ�� vo���
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// ���� �۵��� - OK �����ڵ�� uuid�� ���� ���ϸ� ���� 
		}
		
		return new ResponseEntity<List<AttachVO>>(attachList,HttpStatus.OK);
	}
	
	//����� �̹����� �����ϴ� ��Ʈ�ѷ�
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("����� ��û "+fileName);
		File f = new File("d:\\upload\\images\\"+fileName);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		try {
			headers.add("Content-Type", Files.probeContentType(f.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(f),headers,HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

	
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName,String uuid){
		
		log.info(" file  : "+fileName+" uuid : "+uuid);
		
		try {
			File file = new File("d:\\upload\\images\\"+URLDecoder.decode(fileName,"utf-8"));
			
			log.info("uuid ���� ����"+service.deleteUuid(uuid));
			//����� Ȥ�� �Ϲ����� ����
			if(service.deleteUuid(uuid)) {
				file.delete();				
			}
			
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		log.info("deleteFile : "+fileName);
		return new ResponseEntity<String>("success",HttpStatus.OK);
		
	}
	
	
	
	
	
	
}
