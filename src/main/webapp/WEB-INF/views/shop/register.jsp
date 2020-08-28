<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<script>
	if('${info}'!=''){
		alert('${info}');
	}
</script>

        <div class="buypage">
            <div class="imagepage">
                            <div class="uploadResult">
	                            <ul>
	                            </ul>
                        	</div>
                <img id="default" src="http://via.placeholder.com/800x500" alt="" width="100%" height="100%" padding="0px">

            </div>
            
            
            
            <form action="" class="infopage" method="post" role="form">
                   <div class="pro-info1">
                       <h2>상품명</h2>
                       <input type="text" name="productname" class="input-info" placeholder="상품명을 입력해 주십시오." required="required">
                       <p class="font-accent" style="padding: 0px">상품가격</p>
                       <input type="text" name="price" class="input-info" placeholder="상품가격을 입력해 주십시오." required>
                       <p class="font-accent" style="padding: 0px">상품설명</p>
                       <textarea name="explanation"cols="30" rows="10"></textarea>
                   </div>
                   
                   <div class="select-size">
                       <h2>사이즈 종류</h2>
                           <input type="checkbox" name="productsize" value="Free">Free
                           <input type="checkbox" name="productsize" value="90">90
                           <input type="checkbox" name="productsize" value="100">100
                           <input type="checkbox" name="productsize" value="110">110
                       <div>
                           <h3 class="input-info">분류</h3>
                           <select name="producttype">
                               <option value="기타용품">기타용품</option>
                               <option value="신발">신발</option>
                               <option value="의류">의류</option>
                           </select>
                           <h3 class="input-info">브랜드</h3>
                           <select name="brand">
                               <option value="기타브랜드">기타브랜드</option>
                               <option value="Nike">Nike</option>
                               <option value="Adidas">Adidas</option>
                           </select>
                           <h3 class="input-info">성별</h3>
                           <select name="gender">
                               <option value="공용">공용</option>
                               <option value="남성">남성</option>
                               <option value="여성">여성</option>
                           </select>
                           <h2>재고</h2>
                           <input type="text" name="inventory">개
                       </div>
                       <input type="hidden" name="userid" value="${login.userid }" />
                       <button type="submit" class="btn btn-black" value="등록하기" >등록하기</button>
                       <button type="button" class="btn btn-black" onclick="location.href='/shop/proview'">목록으로</button>
						
                           <h3>상품 이미지 등록 (필수)</h3>
                           <input type="file" name="uploadFile" multiple="multiple">
                </div>
           </form>


            </div>

        </div>


            
            <script>
            
            
            
            $(function(){
            	
            	
                $("button[type='submit']").click(function(){
                	//게시글 등록 + 파일 첨부 한꺼번에 처리
                	//첨부 파일 내용 수집
                	let str="";
                	$(".uploadResult ul li").each(function(i, ele){
                		let job = $(ele);
                		
                		str+="<input type='hidden' name='attachList["+i+"].uuid' value = '"+job.data("uuid")+"'>"
                		str+="<input type='hidden' name='attachList["+i+"].uploadPath' value = '"+job.data("path")+"'>"
                		str+="<input type='hidden' name='attachList["+i+"].fileName' value = '"+job.data("filename")+"'>"
                			
                	})
                	console.log(str);
                	
                	
                	//해당 폼 전송
                	$("form[role='form']").append(str);
                })
                
            	
            	//업로드버튼이 눌러지면 업로드 파일에 올라온 파일들을 스크립트에...ㅁㄴㅇ?
            		$("input[type='file']").change(function(){
            			// form 의 형태로 데이터를 구성할 수 있음.
            			// key:value 의 형태로 구성함
            			let formData = new FormData();
            			
            			// 첨부파일 목록 가져오기
            			let uploadFile = $("input[name=uploadFile]");
            			let files = uploadFile[0].files;
            			console.log(files)
            			
            			//form의 형태로 붙이기
            			for(var i=0;i<files.length;i++){
            				if(!checkExtension(files[i].name,files[i].size)){
            					return false;
            				}
            				formData.append("uploadFile",files[i]);
            			}
            			
            			$.ajax({
            				url:'/uploadAjax',
            				type:'post',
            				processData:false,  // 데이터를 query string( http://~~~?uploadFile=테스트.txt )으로 변환할 것인지 결정  
            									// 기본값은 application/x-www-form-urlencoded 로 true 이기 떄문에 false로 지정
            				contentType:false,  // 기본값은 application/x-form-urlencoded  
            									// 파일의 경우에는 enctype 은 multipart/form-data로 보내야 하기 떄문에 false로 지정 
            				data:formData,
            				success:function(result){
            					console.log(result);
            					showUploadFile(result);
            					$("input[name = 'uploadFile']").val("");
            				},
            				error:function(xhr,txtstatux,error){
            					alert(xhr.responseText);
            				}
            				
            			})
            			
            		})
            		
            		// 첨부파일 제한 / 크기 제한
            		function checkExtension(fileName,fileSize){
            			let regex = new RegExp("(.*?)\.(jpg|png)$");
            			let maxSize = 2097152;  //2Mb
            			
            			if(fileSize > maxSize){
            				alert("파일 사이즈 초과")
            				return false;
            			}
            			if(!regex.test(fileName)){
            				alert("오직 jpg, png 파일만 올릴 수 있습니다.")
            				return false;
            			}
            			return true;
            	}
            	
 				
            		//업로드 된 파일 보여주기
            		function showUploadFile(uploadResultArr){
            			//결과를 보여줄 영역 가져오기
            				 let str="";
            			let uploadResult = $(".uploadResult ul");
            			$(uploadResultArr).each(function(i, element) {   //  EL에서의 향상된 for문역할 i = 받은값의 길이(for문 돌 길이), element = 받은값[i].으로 사용한 받은값 의 변수명

            					 var fileCallPath = encodeURIComponent(element.uuid+"_"+element.fileName);
            				 //var oriPath = element.uploadPath+"//"+element.uuid+"_"+element.fileName
             				 //oriPath = oriPath.replace(new RegExp(/\\/g),"/");
            				  	 str += "<li data-path='"+element.uploadPath+"' data-uuid='"+element.uuid+"' ";
            				  	 str += "data-filename='"+element.fileName+"'>"
            					 str += "<img src='/display?fileName="+fileCallPath+"' width='100%' height='100%'>";
               					 str += "<button type='button' class='btn btn-squre' style='width:50px;, height:30px;' data-file='"+fileCallPath+"' data-type='file'>x</button>";
            				  	 str +="</li>";
            					 $("#default").hide();
            				 	console.log(element.fileName)
            			})
            			uploadResult.append(str);
            		}
            	
				$(".uploadResult").on("click","button",function(e){

					let targetFile = $(this).data("file");
 					let targetLi=$(this).closest("li");
					
					$.ajax({
						url : '/deleteFile',
						
						type : 'post',
						data : {
							fileName : targetFile
						},
					success : function(result){
						targetLi.remove();
					}
					})
 				
				// 다음 이벤트 발생 막기
				e.stopPropagation();  
			}) //  첨부 파일 삭제 종료 
   })
            
            
            
            </script>
            


<%@include file="../includes/footer.jsp" %>       