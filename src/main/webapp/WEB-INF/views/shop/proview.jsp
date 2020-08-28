<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>





<!-- 

var fileCallPath = encodeURIComponent(element.uploadPath+"/s_"+element.uuid+"_"+element.fileName);

<li data-path='element.uploadPath' data-uuid='element.uuid' data-filename='element.fileName' data-type='element.fileType'> 
	<a href=\"javascript:showImage(\'oriPath\')\">
		<img src='/display?fileName=fileCallPath'><div>element.fileName     
		// img 의 src가 display를 거쳐감. display에 주소를 초기화?하는 방법이 있는지 확인해보기  String타입의 filename값을 받음. 
		fileName은 D:\upload\images\구글.png처럼 파일의 위치가 담긴 String형식의 주소가 담겨있음 
	</a>
	<button type='button' class='btn btn-warning btn-circle btn-sm' data-file='fileCallPath' data-type='image'>
		<i class='fa fa-times'></i> </button>
	</div>
</li>;

 -->



        <div class="main test">
            <div>
                <p>Men</p>
                <br>
                <h3>Men's 의류</h3>
            </div>
            <div class="main-proview font-accent">



	 <!-- var fileCallPath = encodeURIComponent(element.uploadPath+element.uuid+"_"+element.fileName); -->

				<c:forEach var="vo" items="${list }">
                <div class="pro">
                    <a href="/shop/buypage?pno=${vo.pno }">
                     <c:if test="${vo.attach!=null }">
                    <img src="/display?fileName=${vo.attach.uuid}_${vo.attach.fileName}" alt="can't find" width="100%" height="450px"padding="0px">
                    </c:if>
                    <c:if test="${vo.attach==null }">
                    <img src="http://via.placeholder.com/800x500" alt="can't find" width="100%" height="450px"padding="0px">
                    </c:if>
                    </a>
                    
	                    <div class="pro-info">
                        <h2>${vo.productname }</h2>
                        <p class="name">${vo.gender } ${vo.productname }</p>
                        <p class="name">1컬러</p>
                    </div>
                    <div>
                        <p class="pro-info-price">${vo.price }원</p>
                    </div>
                    <input type="hidden" name="pno" value="${vo.pno }" />
                </div>
				</c:forEach>
				

	
	
                 <!-- 페이징 -->
<%--                 <div class="text-center">
                    <ul class="pagination">
                    <c:if test="${page.prev}">
                        <li class="paginate_button"><a href="">Previous</a></li>
                    </c:if>
                        <c:forEach var="idx" begin="${page.startPage}" end="${page.endPage}">
                        <li class="paginate_button font-accent"><a href="${idx }">${idx}</a></li>
                        </c:forEach>
                    <c:if test="${page.next}">
                        <li class="paginate_button"><a href="">Next</a></li>
                    </c:if>
                    </ul>
                </div>  --%>
            <!-- 페이지 번호를 누르면 동작하는 폼 -->
            <form action="proview" id="actionForm">
            	<input type="hidden" name="pageNum" value="${page.cri.pageNum }" />
            	<input type="hidden" name="pageNum1" value="${page.cri.pageNum }" />
            	<input type="hidden" name="amount" value="${page.cri.amount }" />
            </form>

            </div>
            	<div class="text-center">
				<button type="button" class="btn btn-black" id="more-view">더보기</button>
				</div>

        </div>
	<script>
$(function(){
	if('${mv}'=='true'){
		$(".more-view").remove()
	}
	
	console.log($("input[name='keyword']").val());
	
	
	let a = $(".pagination a")
	let actionForm = $("#actionForm");
	
	
	$(a.click(function(e){
	//a 태그의 동작 막기
	e.preventDefault();
	//전송해야 할 폼 가져온 후 pageNum 의 값과 amount값을 변경한 후 	
	actionForm.find("input[name=pageNum]").val($(this).attr("href"));
/* 	if('${cri.keyword}'==''){
 		actionForm.append("<input type='hidden' name='keyword' value='${cri.keyword}' />");
	} */
	//폼 전송하기
	actionForm.submit();
	
	}))		
		let page = $("input[name='pageNum1']").val();
    
	$("body").on("click","#more-view",function(){
		let main = $(".main-proview");
		let main2 = $(".main");
		let keyword = $("input[name='keyword']").val();
		page = parseInt(page);
		page+=1;
		//console.log(page);
		

		
		$.ajax({
			url:'/shop/proview',
			type:'post',
			data:{
				pageNum:page,
				keyword:keyword
			},
			success:function(data){
				//$(".more-view").remove();
				//console.log(data);
				str=""
				for(i=0; i<data.length;i++){
					//console.log(data[i].pno);
				str+=
						"<div class='pro'>"+
						"<a href='/shop/buypage?pno="+data[i].pno+"'>";							
					if(data[i].attach!=null){
						str+=
						"<img src='/display?fileName="+data[i].attach.uuid+"_"+data[i].attach.fileName+"' alt='can t find' width='100%' height='450px'padding='0px'>";
						
						
					}else if (data[i].attach==null){
						str+=
						"<img src='http://via.placeholder.com/800x500' alt='can t find' width='100%' height='450px'padding='0px'>";
					}
					str+=
						"</a>"+
						"<div class='pro-info'>"+
						"<h2>"+data[i].productname+"</h2>"+
						"<p class='name'>"+data[i].gender+""+ data[i].productname+"</p>"+
						"<p class='name'>1컬러</p>"+
						"</div>"+
						"<div>"+
						"<p class='pro-info-price'>"+data[i].price+"원</p>"+
						"</div>"+
						"<input type='hidden' name='pno' value='${vo.pno }' />"+
						"</div>";
						
				}
				

				//console.log(str)
				$(".pro").remove();
				main.append(str);
				
				$("#more-view").remove();
	 				btn=
					"<div class='text-center'>"+
					"<button type='button' class='btn btn-black' id='more-view'>더보기</button>"+
					"</div>";
				main2.append(btn);
				console.log(${cri.amount}*page);
				if(${total}<(${cri.amount}*page)){ 
					$("#more-view").remove();
					btn=
					"<div class='text-center'>"+
					"<button type='button' class='btn'>항목 없음</button>"+
					"</div>";
				main2.append(btn); 
					
				}
			},
			error:function(xhr,textstatus,error){
				alert(xhr.responseText)
			}
			
		})
		
	})
	
})
	
	
	
	</script>


<%@include file="../includes/footer.jsp" %>       