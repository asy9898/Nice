package com.spring.controller;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.EmailAuthVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class EmailController {
	
	public String RandomNum() {
		StringBuffer buffer = new StringBuffer();
		for(int i = 0; i<=6; i++) {
			int n = (int) (Math.random()*10);
			buffer.append(n);
		}
		return buffer.toString();
	}
	
	private void sendEmail(String email,String authNum) {
		String host = "smtp.gmail.com";  // smtp����
		String subject="Nice ������ȣ ����";
		String fromName = "Nice������Ʈ ������";
		String from= "asy9898@naver.com";// ������ ��� �̸���
		String to1 = email;
		
		String content = "������ȣ ["+authNum+"]";

		try {
			Properties props = new Properties();
			props.put("mail.smtp.starttls.enable","true");
			props.put("mail.transport.protocol","smtp");
			props.put("mail.smtp.host",host);
			props.setProperty("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.port","465");
			props.put("mail.smtp.user",from);
			props.put("mail.smtp.auth","true");
			
			
			Session mailSession = Session.getInstance(props,
					new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("goodkimchi76","a6758828");  //�����»�� �̸��� id,��й�ȣ
				}
			});
			
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from,MimeUtility.encodeText(
					fromName,"UTF-8","B"))); // ������ ��� ����
			
			InternetAddress[] address1 = { new InternetAddress(to1) };
			msg.setRecipients(Message.RecipientType.TO, address1); // �޴� �������1
			msg.setSubject(subject); //���� ����
			msg.setSentDate(new java.util.Date()); // ������ ��¥ ����
			msg.setContent(content,"text/html;charset = euc-kr"); // ���� ����(HTML����)
			
			Transport.send(msg); // ���� ������
		} catch (MessagingException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	
	@PostMapping("/emailAuth")
	public ResponseEntity<EmailAuthVO> emailAuth(String email,RedirectAttributes rttr) {
		String authNum = "";
		authNum = RandomNum();
		sendEmail(email.toString(),authNum);
		EmailAuthVO vo = new EmailAuthVO();
		vo.setEmail(email);
		vo.setAuthNum(authNum);
		return new ResponseEntity<EmailAuthVO>(vo,HttpStatus.OK);
	}
	
	
}
