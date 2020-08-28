<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>


        <div class="main" style="text-align: center;">
            <div style="text-align: center; padding-bottom: 40px;" class="div">
             	    <h2><c:forEach begin="1" end="5" var="i"> 
                    <c:if test="${score>=i}"><img src="/resources/images/별.png" alt=""  width="22px" height="22px" /></c:if>
                    <c:if test="${score<i}"><img src="/resources/images/빈별.png" alt=""  width="22px" height="22px" /></c:if>
                    </c:forEach></h2>
                <h2>${r_count}개의 Review / ${score} STARS</h2>
                    
            </div>

            <div class="main-review">
                <table>
                  <colgroup>
                  </colgroup>
                  
                  
                  <c:forEach var="vo" items="${review }">
                  <tr style='display: block; padding: 30px 0px;' class='div'>
                      <td style='display: inline-block;'>
                          <h4>${vo.r_title }</h4>
                  	   <p><c:forEach begin="1" end="5" var="i"> 
                        <c:if test="${vo.score>=i}"><img src="/resources/images/별.png" alt=""  width="13px" height="13px" /></c:if>
                        <c:if test="${vo.score<i}"><img src="/resources/images/빈별.png" alt=""  width="13px" height="13px" /></c:if>
                         </c:forEach></p>
                          <!-- <p>★★★★☆</p> -->
                          <p class="mini">${vo.userid } - ${vo.r_regdate }</p>
                      </td>
                      <td>${vo.r_content }</td>
                  </tr>
                  </c:forEach>
<!--                   <tr style="display: block; padding: 30px 0px;" class="div">
                      <td style="display: inline-block;">
                          <h4>댓글제목</h4>
                          <p>★★★★☆</p>
                          <p class="mini">작성자 - 2020-08-24</p>
                      </td>
                      <td>Lorem ipsum dolor sit amet consectetur adipisicing elit. Provident, non nam. Molestiae tenetur dignissimos consequuntur, eum unde itaque, repudiandae perspiciatis a quibusdam eveniet cupiditate. Tempora voluptas aspernatur incidunt itaque illum!</td>
                  </tr> -->
                </table>
            </div>
        </div>


<%@include file="../includes/footer.jsp" %>       