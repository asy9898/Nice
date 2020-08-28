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
		log.info("upload Ajax 요청");
		String uploadFolder = "d:\\upload\\";
		String uploadFileName = "";
		
		String uploadFolderPath = "images\\";
		File uploadPath = new File(uploadFolder,uploadFolderPath);  //uploadFolder 경로에 uploadFolderPath의 이름의 파일 생성
		
		if(!uploadPath.exists()) { //이미 만들어져있지 않다면
			uploadPath.mkdirs(); //uploadFolderPath의 이름으로 폴더 생성
		}
		
		// 여기까지 작업 = d드라이브의 upload폴더에 폴더생성
		
		
		
		//요청받은 파일 받기 시작
		List<AttachVO> attachList = new ArrayList<AttachVO>();
		for(MultipartFile f:uploadFile) { //각 VO 삽입작업
			log.info("-------------------------------");
			log.info("upload File Name : "+f.getOriginalFilename());
			log.info("upload file Size : "+f.getSize()+"Byte");
			
			//파일의 중복을 제거하기 위해서, 고유값 설정
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString()+"_"+f.getOriginalFilename(); //변경할 이름 (uuid값+파일명) 준비
			
			AttachVO attach = new AttachVO(); // 받은파일들  각각 파일명 , 경로지정 , uuid값 지정
			attach.setFileName(f.getOriginalFilename());
			attach.setUploadPath(uploadFolderPath);
			attach.setUuid(uuid.toString());
			
			
			try {
				Path saveFile = Paths.get(uploadPath.getPath(),uploadFileName);   // 각각 지정한 파일들을 uploadPath(날짜로 폴더 만든곳)에 변경한 이름으로 저장준비

				f.transferTo(saveFile); // 각 파일들 저장
				attachList.add(attach);  //리스트에 vo담기
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// 정상 작동시 - OK 상태코드와 uuid가 붙은 파일명 리턴 
		}
		
		return new ResponseEntity<List<AttachVO>>(attachList,HttpStatus.OK);
	}
	
	//썸네일 이미지를 리턴하는 컨트롤러
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		log.info("썸네일 요청 "+fileName);
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
			
			log.info("uuid 삭제 실행"+service.deleteUuid(uuid));
			//썸네일 혹은 일반파일 삭제
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
