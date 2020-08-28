<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
	<c:if test="${vo.pno==''}">

        <div class="buypage">
            <div class="imagepage">
                <img src="/resources/images/2.jpg" alt="" width="100%" height="900px"padding="0px">
                <img src="/resources/images/2.jpg" alt="" width="100%" height="900px"padding="0px">    
            </div>
            <div class="infopage">
                <div class="pro-info1">
                    <h2>조던 23 엔지니어드 AW84 캡</h2>
                    <p class="font-accent"> 39,000 원</p>
                </div>
                
                <div class="select-size">
                    <h2>사이즈 선택</h2>
                    <button class="btn btn-squre">Free</button>
                    <button class="btn btn-squre">90</button>
                    <button class="btn btn-squre">100</button>
					
                    <div>
                        <h2>수량</h2>
                        <p>0</p>
                        <img src="/resources/images/as.png" alt="" width="20px" height="20px"padding="0px" style="cursor:pointer">
                        <img src="/resources/images/dw.png" alt="" width="20px" height="20px"padding="0px" style="cursor:pointer">
                    </div>
                    

                </div>

                <div>
                    <button class="btn btn-long font-accent">바로구매</button>
                </div>
                <button class="btn-white btn-long font-accent">장바구니</button>
            </div>
        </div>
	</c:if>
	
	
	
	
	
	<c:if test="${vo.pno!=''}">
        <div class="buypage">
            <div class="imagepage" style="text-align:left ">
            	<c:if test="${fn:length(vo.attachList)>3 }">
            <c:forEach var="img" items="${vo.attachList }">
                <img src="/display?fileName=${img.uuid}_${img.fileName}" alt="can't find" width="48%" height="420px"padding="0px">
            </c:forEach>
            	</c:if>
            	<c:if test="${fn:length(vo.attachList)<=3 }">
            <c:forEach var="img" items="${vo.attachList }">
                <img src="/display?fileName=${img.uuid}_${img.fileName}" alt="can't find" width="100%" height="auto"padding="0px">
            </c:forEach>
            	</c:if>
             </div>
             <div class="infopage">

            <form action="buypage" method="post" role="form">
                <div class="pro-info1">
                    <h2>${vo.productname }</h2>
                    <p class="font-accent"> ${vo.price} 원</p>
                </div>
                
                <div class="select-size ">
                    <h2>사이즈 선택</h2>
                    <div id="size"> 
<!--                            <input type="button" class='btn btn-black btn-active'  value="Free">
                           <input type="button" class='btn btn-black btn-active'  value="110">
                           <input type="button" class='btn btn-black btn-active'  value="100">
                           <input type="button" class='btn btn-black btn-active'  value="90"> -->
                    </div>
                    <div  style="padding-bottom: 30px">
                        <h3>수량</h3>
                       <li>
                        <input type="text" value="1" name="amount" readonly="readonly"/>
                        <img id="up" src="/resources/images/as.PNG" alt="can't find!" width="20px" height="20px"padding="0px" style="cursor:pointer">
                        <img id="down" src="/resources/images/dw.PNG" alt="can't find" width="20px" height="20px"padding="0px" style="cursor:pointer">
                       </li>
                    
                    </div>
                
                </div>
                

                <div class="div" style="padding-bottom: 30px">
                    <button id="buy" type="button" class="btn btn-black btn-long font-accent">바로구매</button>
                <input type="hidden" name="productsize"/>
                <input type="hidden" name="pno" value="${vo.pno }"/>
                <input type="hidden" name="userid" value="${login.userid }"/>
                <button id="cart" type="button" class="btn-white btn-long font-accent">장바구니</button>
				<p><br /></p>
				<c:if test="${login.userid==vo.userid }">
                <button id="update" type="button" style="width: 49%" class="btn-warn btn-long font-accent">상품 수정</button>
                <button id="delete" type="button" style="width: 49%" class="btn-red btn-long font-accent">상품 삭제</button>
				</c:if>
                </div>
                <div class="div"  style="padding: 30px 0px">
                	<p>${vo.explanation }</p>
                </div>
            </form>
                        <div class="div"  style="padding: 30px 0px">
                        <div id="show-re" class="div" style="margin-bottom: 20px; cursor: pointer;">
                        <input type="hidden" name='up-down' value=1 />
                        <h5 style="float: left;">리뷰 (${r_count})</h5>
                        <h3 style="text-align: right;"><c:forEach begin="1" end="5" var="i"> 
                    <c:if test="${score>=i}"><img src="/resources/images/별.png" alt=""  width="14px" height="14px" /></c:if>
                    <c:if test="${score<i}"><img src="/resources/images/빈별.png" alt=""  width="14px" height="14px" /></c:if>
                    </c:forEach><img src="/resources/images/dw.PNG" alt="img" style="width: 20px; height: auto;"></h3>
                        </div>
					<form action='/review/insertReview' method='post' id='reviewForm'>
					</form>
                        
                        <div id="read-re">
                    <table>
                    <tr>
                        <a href='' class='review font-accent write-review'>리뷰 작성하기</a>
                            <c:forEach var="vo" items="${review}">
                        <td class="mini" style="padding: 20px 0px; display: block;">
                        <h3>${vo.r_title }</h3>
                        <p> <c:forEach begin="1" end="5" var="i"> 
                        <c:if test="${vo.score>=i}"><img src="/resources/images/별.png" alt=""  width="13px" height="13px" /></c:if>
                        <c:if test="${vo.score<i}"><img src="/resources/images/빈별.png" alt=""  width="13px" height="13px" /></c:if>
                         </c:forEach> &nbsp;&nbsp;${vo.userid }&nbsp;&nbsp;&nbsp;&nbsp;${vo.r_regdate }</p>
                        <p>${vo.r_content }</p>
                        </td>
                            </c:forEach>
                        <td class="mini" style="display: block;">
                        <a href="/shop/review?pno=${vo.pno }" class="review font-accent">더 많은 리뷰 보기</a>
                        </td>
                    </tr>
                </table>
                        </div>
                </div>

             </div>
        </div>
	</c:if>
	
<!-- 	if(text.indexOf(findString) != -1) {
		alert("성공!");
		} -->
	
	<script>
	
	
	
	
	
 		let reviewForm = $("#reviewForm");
 		let reRead = $("#read-re");
 		let show=$("#show-re")
 		//reviewForm.css("visibility","hidden");
 		reRead.css("visibility","hidden");
 		
		
 		
 	$(function(){
 		
 		$("body").on("click",".btn-re",function(e){
 			e.preventDefault();
 			
 			if('${login.userid}'!=''){
 				reviewForm.submit();
 			}else{
 				alert("로그인이 필요한 기능입니다.")
 				return false;
 			}
 			
 		})
 		
 		
 		show.on("click",function(){
 		let ud = $("input[name='up-down']");
 		
 		if(ud.val()==1){
 		reviewForm.css("visibility","visible");
 		reRead.css("visibility","visible");
 		$(".write-review").css("visibility","visible");
 		//let img = (this).closest($("img"));
 		let img = $("img[alt='img']");
 		img.attr("src","/resources/images/as.PNG") 
 		ud.val(0);
 		}else{
 			reviewForm.css("visibility","hidden");
 		reRead.css("visibility","hidden");
 		$(".write-review").css("visibility","hidden");
 		//let img = (this).closest($("img"));
 		let img = $("img[alt='img']");
 		img.attr("src","/resources/images/dw.PNG")
 		ud.val(1);
 		}
 			
 		console.log();
 		//img.attr("src","/resources/images/as.PNG");
 		
 		})
 		
 		$(".write-review").on("click",function(e){
 			e.preventDefault();
 			
		str=
			"<div id='write-re'>"+
			"<input type='image' src='/resources/images/별.png' value=1 width='20px' height='20px'/>"+
			"<input type='image' src='/resources/images/별.png' value=2 width='20px' height='20px'/>"+
			"<input type='image' src='/resources/images/별.png' value=3 width='20px' height='20px'/>"+
			"<input type='image' src='/resources/images/별.png' value=4 width='20px' height='20px'/>"+
			"<input type='image' src='/resources/images/별.png' value=5 width='20px' height='20px'/>"+
			"<div><label for=''>제목</label></div>"+
			"<input type='text' name='r_title' required='required'>"+
			"<div><label for='content'>내용</label></div>"+
			"<textarea name='r_content' cols='30' rows='10' required='required'></textarea>"+
			"<div><input type='hidden' name='score' value='5'>"+
			"<input type='hidden' name='userid' value='${login.userid }'>"+
			"<input type='hidden' name='pno' value=${vo.pno }>"+
			"</div>"+
			"<button class='btn btn-black mini btn-re' style='width: 80px; height: 30px; margin-right:20px;'>리뷰등록</button>"+
			"<a href='' class='hide-write'><img src='/resources/images/as.PNG' alt='asd' style='width: 20px; height: auto;'></a>"+
			"</div>";
			reviewForm.append(str);
			$(".write-review").hide();
		})
		$("body").on("click",".hide-write",function(e){
			e.preventDefault();
			//alert("asd");
			$("#write-re").remove();
			$(".write-review").show();
		})
		
	
	
 		$("input[name='amount']").val(1);
 		let form = $("form[role='form']");
 		
 		str="";
 		
 		let sizearr = '${vo.productsize}'.split(",");
		sizearr.forEach(function(data){
			str+="<input type='button' class='btn btn-black btn-active'  value='"+data+"'>";
			console.log(data)
		})
 		$("#size").append(str);
 		
 		
 		$("#cart").on("click",function(){
 			if($("input[name='productsize']").val()==''){
 				alert("사이즈를 선택 해 주십시오.");
 				return false;
 			}
 			
 			let cart = {
 				productsize : $("input[name='productsize']").val(),
 				userid : $("input[name='userid']").val(),
 				pno : $("input[name='pno']").val(),
 				amount: $("input[name='amount']").val()
 			}
 			if($("input[name='userid']").val()!=""){
 				
 			$.ajax({
 				url:'cart',
 				type:'post',
 				data: cart,
 				success:function(result){
 					if(result=="success"){
 						alert("장바구니에 담겼습니다.")
 					}
 				},error:function(xhr,txtstatus,error){
 					alert(xhr.responseText)
 				}
 				
 			})
 			}else{
 			alert("로그인이 필요한 서비스입니다.");
 			form.attr("action","/member/login");
 			form.attr("method","get");
 			form.submit();
 			}
 			
 		})
 		
 		
 		$("#buy").on("click",function(){
 			form.attr("action","buy")
 			//form.submit();
 		})
 		
 		$("#update").on("click",function(){
 			form.attr("action","modify")
 			form.attr("method","get")
 			form.submit();
 		})
 		
 		$("#delete").on("click",function(){
 			form.attr("action","deleteProduct")
 			form.submit();
 		})
 		
 		
 		$(".btn-active").on("click",function(){
 			let value = $(this).val();
 			let size = $("input[name='productsize']");
 			size.val(value);
 			//alert(size.val())
 			$(".btn-active").removeClass("btn-white");
 			$(this).addClass("btn-white");


 			
 		})
 		
 		
 		
	let amount = $("input[name='amount']").val();
	
	$("#up").on("click",function(){
		amount = $(this).closest("li").find("input[name='amount']").val();
		amount++;
		console.log(amount);
		$("input[name='amount']").val(amount);
	})
	$("#down").on("click",function(){
		amount = $(this).closest("li").find("input[name='amount']").val();
		if(amount<=1){
			alert("1개 이하로 내릴 수 없습니다.");			
			return;
		}
		amount--;
		console.log(amount);
		$("input[name='amount']").val(amount);
	})
	
	
	$("body").on("click","input[type='image']",function(e){
		e.preventDefault();
		let score = $(this).val();
		
		$("input[type='image']").each(function(){
			
			if($(this).val()>score){
				$(this).prop("src","/resources/images/빈별.png")
			}else if($(this).val()<=score){
				$(this).prop("src","/resources/images/별.png")
			}
		});
			$("input[name='score']").val(score);
		
	})
	
	
	})
	
	
		
	</script>

<%@include file="../includes/footer.jsp" %>       