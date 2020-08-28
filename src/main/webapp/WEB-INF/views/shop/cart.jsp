<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	if('${info}'!=''){
		alert('${info}');
	}
</script>


        <div class="main middle">

			<c:if test="${cart.isEmpty()||login==null}">
            <div class="div center padding-bottom-40">
                <h2>장바구니</h2>
                <p class="color">0개상품</p>
            </div>
            <div class="div center padding-top-40">
                <img src="/resources/images/캡처.PNG" alt="">
                <p>장바구니에 담긴 상품이 없습니다.</p>
                <button class="btn btn-squre btn-black" style="font-size: 0.9em; width: 150px" onclick="location.href='/shop/proview'">계속 쇼핑하기</button>
            </div>
			</c:if>
			
            <c:if test="${!cart.isEmpty()&&login!=null}">
            <div class="div center padding-bottom-40">
                <h2>장바구니</h2>
                <p class="color">${cart.size() }개상품</p>
            </div>
            
            <div class="inline">

                <form id="actionForm" action="deleteCart" method="post"  class="div inline margin-right-40" style="width: 65%">
                    <table style="width: 100%; text-align: left; vertical-align: middle;" class="padding-bottom-40"> 
                    <colgroup>
                    <col style="width: 5%">
                    <col style="width: 15%">
                    <col style="width: 55%">
                    <col style="width: 19%">
                    </colgroup>
                        <thead>
                        <tr class="text-center" style='background-color: rgb(214, 210, 210);'>

                        	<td scope="col"><input type="checkbox" checked="checked" name="all-check" class = 'btn btn-squre' style='width: 20px; height: 20px; line-height: 30px;'></td>
                        	<td scope="col"><p>상품 사진</p></td>
                        	<td scope="col">상품 내용</td>
                        	<td scope="col">상품 가격</td>
                        </tr>
                        	<c:forEach var="vo" items="${cart }">
                            <tr class="text-center">
                            <td>
                                <input type="checkbox" checked="checked" name="cartid" class = 'btn btn-squre' style='width: 20px; height: 20px; line-height: 30px;' value="${vo.cartid }">
                            </td>
                                <td scope="col">
                                <li>
                             <%--    <input type="checkbox" checked="checked" name="cartid" class = 'btn btn-squre' style='width: 20px; height: 20px; line-height: 30px;' value="${vo.cartid }"> --%>
                                 <a href="buypage?pno=${vo.pno }"><img src="/display?fileName=${vo.attach.uuid}_${vo.attach.fileName}" alt="asd" width="120px" height="80px"></a></td>
                                </li>
                                <td scope="col" >
	                                    <p class="font-accent">${vo.productname}</p>
	                                    <p>스타일 : CD4256-101</p>
	                                    <p>가격 : ${vo.price }</p>
	                                    <p>사이즈 :${vo.productsize }</p>
			                       <li>
			                        <input type="hidden" value="${vo.price }" name="price"/>
			                        <input type="hidden" value="${total }" name="total"/>
			                        <input type="hidden" value="${vo.productsize }" name="productsize"/>
			                        <input type="hidden" value="${vo.pno }" name="pno"/>
			                        <input type="text" value="${vo.amount }" name="amount" readonly="readonly"/>
			                        <img class="up" src="/resources/images/as.PNG" alt="can't find!" width="20px" height="20px"padding="0px" style="cursor:pointer">
			                        <img class="down" src="/resources/images/dw.PNG" alt="can't find" width="20px" height="20px"padding="0px" style="cursor:pointer">
			                       </li>
                                  
                                  
                                </td>
                                <td scope="col">
                                	<div class="pro-info">
                                	<p>${vo.price*vo.amount} 원</p>
                                	</div>
                                </td>
                            </tr>
                        	</c:forEach>
                        </thead>
                    </table>
                </form>

                <div class="inline line-top" style="width: 29%; float: right; padding-bottom: 10px; border: 1px solid rgb(214, 210, 210);">
                    <div style="background-color: rgb(214, 210, 210);">
                        <h4 style="padding: 20px;">주문예정금액</h4>
                    </div>

                    <div class="inline bill" style="width: 49%; text-align: left;">
                        <p>상품금액</p>
                        <p>상품 할인금액</p>
                        <p>주문 할인금액</p>
                        <h3>총 결제 예정 금액</h3>
                    </div>
					
                    <div class="inline bill pro-bill">
                        <p>${total} 원</p>
                        <p>0 원</p>
                        <p>0 원</p>
                        <h3>${total} 원</h3>
                    </div>
                  		<div class="center" style="margin: 0px 20px;">
                        <button id="pay" class="btn font-accent btn-warn" style="width: 100%; height: 47px; ">주문하기</button>
                        <button type="button" class="btn btn-black font-accent delete-btn" style=" width: 100%; height: 47px; margin: 0px; ">삭제하기</button>
                    </div>
                </div>
            </div>
            </c:if>
        </div>

<script>
$(function(){
	let form = $("#actionForm");
	$(".delete-btn").on("click",function(e){
		e.preventDefault();
	if($("input[name='cartid']:checked").length!=0){
		form.submit();		
	}else{
		alert("삭제 할 항목이 없습니다.")
	}
		/* form.attr("action","/shop/deleteCart"); */

	})
/* 	let targetLi=$(this).closest("li"); */
	
	
	$("#pay").on("click",function(){
	        var IMP = window.IMP; // 생략가능
	        IMP.init('imp46934209'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	        var msg;
	        
	        IMP.request_pay({
	            pg : 'kakaopay',
	            pay_method : 'card',
	            merchant_uid : 'merchant_' + new Date().getTime(),
	            name : '겨울 필수품 요넥스 파카! 외 2건',
	            amount : ${total}, 
	            buyer_email : '${login.email}',
	            buyer_name : '${login.username}',
	            buyer_tel : '${login.phone}',
	            buyer_addr : '${login.address}',
	            buyer_postcode : '123-456',
	            //m_redirect_url : 'http://www.naver.com'
	        }, function(rsp) {
	            if ( rsp.success ) {
	                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
	                jQuery.ajax({
	                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
	                    type: 'POST',
	                    dataType: 'json',
	                    data: {
	                        imp_uid : rsp.imp_uid
	                        //기타 필요한 데이터가 있으면 추가 전달
	                    }
	                }).done(function(data) {
	                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
	                    if ( everythings_fine ) {
	                        msg = '결제가 완료되었습니다.';
	                        msg += '\n고유ID : ' + rsp.imp_uid;
	                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	                        msg += '\결제 금액 : ' + rsp.paid_amount;
	                        msg += '카드 승인번호 : ' + rsp.apply_num;
	                        
	                        alert(msg);
	                    } else {
	                    	alert("결제 실패되었습니다.")
	                        //[3] 아직 제대로 결제가 되지 않았습니다.
	                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
	                    }
	                });
	                //성공시 이동할 페이지
	                location.href='/';
	            } else {
	                msg = '결제에 실패하였습니다.';
	                msg += '에러내용 : ' + rsp.error_msg;
	                //실패시 이동할 페이지
	                location.href="/shop/cart";
	                alert(msg);
	            }
	        });

	})
	let userid = '${login.userid}';
	let bill = $(".pro-bill");
	//let pro = $(".pro-info");
	
	
	$(".up").on("click",function(){
		let amount = $(this).closest("li").find("input[name='amount']").val();
		amount++;
		$(this).closest("li").find("input[name='amount']").val(amount);
		let price = $(this).closest("li").find("input[name='price']").val();
		let pno = $(this).closest("li").find("input[name='pno']").val();
		let productsize = $(this).closest("li").find("input[name='productsize']").val();
		let pro = $(this).closest("tr").find(".pro-info");
		let check = $(this).closest("tr").find("input[name='cartid']");
 		$.ajax({
			url:'/shop/updateCart',
			type:'post',
			data:{
				userid:userid,
				price:price,
				amount:amount,
				pno:pno,
				productsize:productsize
			},
			success:function(result){
				pro.children().remove();
				str="<p>"+result.price*result.amount+" 원</p>";
				pro.append(str);
				if(check.is(":checked")==true){		
					
				bill.children().remove();
				str=
					"<p>"+result.total+" 원</p>"+
					"<p>0 원</p>"+
					"<p>0 원</p>"+
					"<h3>"+result.total+" 원</h3>";
				bill.append(str);
				$("input[name='total']").val(result.total);
				}
 			},
			error:function(xhr,textStatus,error){
				alert(xhr.responseText);
			}
		}) 
	})
	
	
	
	$(".down").on("click",function(){
		let amount = $(this).closest("li").find("input[name='amount']").val();
		if(amount<=1){
			alert("1개 이하로 내릴 수 없습니다.");
			return;
		}
		amount--;
		 $(this).closest("li").find("input[name='amount']").val(amount);
			let price = $(this).closest("li").find("input[name='price']").val();
			let pno = $(this).closest("li").find("input[name='pno']").val();
			let productsize = $(this).closest("li").find("input[name='productsize']").val();
			let pro = $(this).closest("tr").find(".pro-info");
			let check = $(this).closest("tr").find("input[name='cartid']");
			$.ajax({
				url:'/shop/updateCart',
				type:'post',
				data:{
					userid:userid,
					price:price,
					amount:amount,
					pno:pno,
					productsize:productsize
				},
				success:function(result){
					pro.children().remove();
					str="<p>"+result.price*result.amount+" 원</p>";
					pro.append(str);
					//console.log(check.is("checked"))
					if(check.is(":checked")==true){						
					bill.children().remove();
					str=
						"<p>"+result.total+" 원</p>"+
						"<p>0 원</p>"+
						"<p>0 원</p>"+
						"<h3>"+result.total+" 원</h3>";
					bill.append(str);
					$("input[name='total']").val(result.total);
					}
					
				},
				error:function(xhr,textStatus,error){
					alert(xhr.responseText);
				}
			})
	})

	$("input[name='cartid']").on("change",function(){
			console.log("체인지")
		let cartid2 = [];
		
	    $("input[name='cartid']:checked").each(function (index) {
	    	cartid2.push($(this).val());
	    	console.log(index)
	    })
		
	        console.log(cartid2);
	        
	        $.ajax({
	        	url:'/shop/updateTotalPrice',
	        	type:'post',
	        	traditional : true,
	        	data:{
	        		cartid:cartid2
	        	},
				success:function(result){
					//alert(result)
					bill.children().remove();
					str=
						"<p>"+result+" 원</p>"+
						"<p>0 원</p>"+
						"<p>0 원</p>"+
						"<h3>"+result+" 원</h3>";
					bill.append(str);
					$("input[name='total']").val(result);
					
					
				},
				error:function(xhr,textStatus,error){
					alert(xhr.responseText);
				}
	        })
	})
	
	$("input[name='all-check']").on("change",function(){
		if($(this).is(":checked")){
			 $("input[name='cartid']").prop("checked", true).change();
		}else{
			 $("input[name='cartid']").prop("checked", false).change();
		}
	})
	
	
	
	
})

</script>
        
</body>
</html>