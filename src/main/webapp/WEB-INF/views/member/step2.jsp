<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Insert title here</title>
    <!-- resources 앞에 / 를 붙일때는 context path가 없는 경우일 때 -->
    <link
      rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
      crossorigin="anonymous"
    />  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.1/jquery.validate.js"></script>
    <!-- validation 사용자 작성 코드 삽입-->
    <script src="/resources/js/join.js"></script>
    
    
  </head>
  <body style="background-color:#F5F5F5;">
                <a href="/">
                    <img src="/resources/images/1.png" alt="can't find" width="110px" height="auto" style="padding: 20px">
                </a>
  
    <script>
    $(function(){
    	
    let gender = '${vo.gender}';
    console.log(gender);
    if(gender==="남"){
    $("input:radio [name='gender'][value='남']").prop("checked",true);
    }else if(gender==="여"){
    $("input:radio [name='gender'][value='여']").prop("checked",true);
    } 
    })
    </script>
    <div class="container" style="margin-top:40px">
      <form id="regist" method="post" action="step3">
        <div class="form-group row justify-content-center">
          <label for="userid" class="col-sm-2 col-form-label">아이디</label> 
          <div class="col-sm-6">
            <input
              type="text"
              name="userid"
              id="userid"
              class="form-control"
              placeholder="아이디를 입력해 주세요"
              value="${vo.userid }"
            />
            <small id="userid" class="text-info"></small>
          </div>
        </div>
        <div class="form-group row justify-content-center">
          <label for="pass1" class="col-sm-2 col-form-label">비밀번호</label>
          <div class="col-sm-6">
            <input
              type="password"
              name="password"
              id="password"
              class="form-control"
              placeholder="비밀번호를 입력해 주세요"
              required="required"
            />
            <small id="password" class="text-info"></small>
          </div>
        </div>
        <div class="form-group row justify-content-center">
          <label for="pass2" class="col-sm-2 col-form-label"
            >비밀번호 확인
          </label>
          <div class="col-sm-6">
            <input
              type="password"
              name="confirm_password"
              id="confirm_password"
              class="form-control"
              placeholder="비밀번호를 다시 입력해 주세요"
              required="required"
            />
            <small id="confirm_password" class="text-info"></small>
          </div>
        </div>
        <div class="form-group row justify-content-center">
          <label for="name" class="col-sm-2 col-form-label">이름 </label>
          <div class="col-sm-6">
            <input
              type="text"
              name="username"
              id="username"
              class="form-control"
              placeholder="이름을 입력해 주세요."
              value="${vo.name }"
              required="required"
            />
            <small id="username" class="text-info"></small>
          </div>
        </div>
        
        <div class="form-group row justify-content-center">
          <label for="name" class="col-sm-2 col-form-label">휴대폰 </label>
          <div class="col-sm-6">
            <input
              type="text"
              name="phone"
              id="phone"
              class="form-control"
              placeholder="휴대폰 번호를 -없이 입력해 주세요. ex)01012341234"
              required="required"
            />
            <small id="phone" class="text-info"></small>
          </div>
        </div>
        
        <div class="form-group row justify-content-center">
          <label for="name" class="col-sm-2 col-form-label">집주소 </label>
          <div class="col-sm-6">
            <input
              type="text"
              name="address"
              id="address"
              class="form-control"
              placeholder= "주소를 입력해 주세요."
              required="required"
            />
            <small id="address" class="text-info"></small>
          </div>
        </div>
        
        <div class="form-group row justify-content-center">
          <label for="pass2" class="col-sm-2 col-form-label">성별 </label>
          <div class="col-sm-6">
          
            <div class="form-check form-check-inline">
              <input
                type="radio"
                id="gender"
                name="gender"
                value="남"
                class="form-check-input"
              />남
            </div>
            <div class="form-check form-check-inline">
              <input
                type="radio"
                name="gender"
                value="여"
                class="form-check-input"
              />여
            </div>
            <small id="gender" class="text-info"></small>
          </div>
        </div>
        <div class="form-group row justify-content-center">
          <label for="email" class="col-sm-2 col-form-label">이메일</label>
          <div class="col-sm-6">
            <input
              type="email"
              name="email"
              id="email"
              class="form-control"
              placeholder="example@gmail.com"
              value="${vo.email }"
              required="required"
            />
            <button type="button" class="btn-email" style="margin: 10px 0px;">인증번호 보내기</button>
            <div style="visibility: hidden;" id="authDiv">
            <input type="text" name="e-auth" placeholder="인증번호 입력" />
            <button type="button" class="btn-auth">인증하기</button>
            <input type="hidden" name="authNum"/>
            <input type="hidden" name="next" value="0"/>
            </div>
            <small id="email" class="text-info"></small>
          </div>
        </div>
        <div class="form-group text-center">
          <input type="submit" class="btn btn-primary" value="입력">
          <button type="reset" class="btn btn-secondary">취소</button>
          <a role="button" href="step1" class="btn btn-secondary">뒤로</a>
        </div>
      </form>
    </div>
    
    
    <script>
    
    $(function(){
    	
    	$(".btn-email").on("click",function(){
    		let auth = $("input[name='authNum']");
    		console.log("이메일버튼 클릭")
		    $.ajax({
		    	url:'/emailAuth',
		    	type:'post',
		    	data:{
		    		email:$("input[name='email']").val()
		    	},
		    	success: function(result){
		    		alert("인증메일이 전송되었습니다.");
		    		auth.val(result.authNum);
		    		console.log(result.authNum);
		    		$("#authDiv").css("visibility","visible")
		    	},
		    	error: function(xhr,textStatus,error){
		    		alert(xhr.responseText);
		    	}
		    	
		    })
    		
    	})
    	
    	$(".btn-auth").on("click",function(){
    		console.log($("input[name='authNum']").val());
    		let num = $("input[name='e-auth']").val();
    		
    		let authnum = $("input[name='authNum']").val();
    		if(num!=authnum){
    			alert("인증번호가 틀립니다.");
    		}else if(num==authnum){
    			alert("인증이 완료되었습니다.")
    			$("input[name='next']").val("1")
    		}
    		
    	})
    	
    	$(".btn-primary").on("click",function(){
    		
    		if($("input[name='next']").val()!="1"){
    			alert("이메일 인증이 되지 않았습니다.")
    			return false;
    		}
    	})
    	
    	
    })
    
    
    </script>
    
    
    
  </body>
</html>
