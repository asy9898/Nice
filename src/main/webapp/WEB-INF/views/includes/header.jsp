<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />



<body>

    
    <div class="div menu-top">
        <ul class="menu-top-left">
            <li> <a href="">Nice</a>  </li>
            <li> <a href="">Join Us</a>  </li>
            <li> <a href="">Image</a>  </li>
            <li> <a href="" style="font-weight: bold;">CONVERSE</a>  </li>
        </ul>
        <ul class="menu-top-right">
        <c:if test="${login!= null}">
            <li> <a href="/shop/register">상품등록</a>  </li>
            <li> <a href="/member/logout">로그아웃</a>  </li>

        </c:if>
        <c:if test="${login == null}">
            <li> <a href="/member/step1">회원가입</a>  </li>
            <li> <a href="/member/login">로그인</a>  </li>   
        </c:if>
            <li> <a href="">고객센터</a>  </li>
            <li> <a href="/shop/cart">Cart</a>  </li>
        </ul>
        </div>


        <div class="div menu-pro">
            <div class="logo logo-first">
                <a href="/">
                    <img src="/resources/images/1.png" alt="can't find" width="70px" height="auto" style="padding-top: 20px">
                </a>
            </div>
            <div class="logo">
                <ul class="middle-tag">
                    <li><a href="/shop/proview">NEW REALEASES</a></li>
                    <div class="div" id="menu-div">
                        <ul class="menu-tag">
                
                            <li><a href="/shop/proview" class="font-accent">신상품</a>                    
                            <ul class="sub-menu first-sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="">MEN</a></li>
                                <li><a href="">WOMEN</a></li>
                                <li><a href="">KIDS</a></li>
                            </ul>
                            </li>
                
                
                            <li><a href="/shop/proview" class="font-accent">신발</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            <li><a href="/shop/proview" class="font-accent">의류</a>                    
	                            <ul class="sub-menu">
	                                <li><a href="">NEW REALEASES</a></li>
	                                <li><a href="">MEN</a></li>
	                                <li><a href="">WOMEN</a></li>
	                                <li><a href="">KIDS</a></li>
	                            </ul>
                           </li>
                
                            <li><a href="/shop/proview" class="font-accent">스포츠</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            
                        </ul>
                    </div>

                    <li><a href="/shop/proview">MEN</a></li>
                    <div class="div" id="menu-div">
                        <ul class="menu-tag">
                
                            <li><a href="" class="font-accent">신상품</a>                    
                            <ul class="sub-menu first-sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="">MEN</a></li>
                                <li><a href="">WOMEN</a></li>
                                <li><a href="">KIDS</a></li>
                            </ul>
                            </li>
                
                
                            <li><a href="" class="font-accent">남성신발</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            <li><a href="" class="font-accent">의류</a>                    
                            <ul class="sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="">MEN</a></li>
                                <li><a href="">WOMEN</a></li>
                                <li><a href="">KIDS</a></li>
                            </ul>
                           </li>
                
                            <li><a href="" class="font-accent">스포츠</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            
                        </ul>
                    </div>

                    <li><a href="/shop/proview">WOMEN</a></li>
                    <div class="div" id="menu-div">
                        <ul class="menu-tag">
                
                            <li><a href="" class="font-accent">신상품</a>                    
                            <ul class="sub-menu first-sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="">MEN</a></li>
                                <li><a href="">WOMEN</a></li>
                                <li><a href="">KIDS</a></li>
                            </ul>
                            </li>
                
                
                            <li><a href="" class="font-accent">여성신발</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            <li><a href="" class="font-accent">의류</a>                    
                            <ul class="sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="">MEN</a></li>
                                <li><a href="">WOMEN</a></li>
                                <li><a href="">KIDS</a></li>
                            </ul>
                           </li>
                
                            <li><a href="" class="font-accent">스포츠</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            
                        </ul>
                    </div>

                    <li><a href="/shop/proview">KIDS</a></li>
                    <div class="div" id="menu-div">
                        <ul class="menu-tag">
                
                            <li><a href="" class="font-accent">신상품</a>                    
                            <ul class="sub-menu first-sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="남성">MEN</a></li>
                                <li><a href="여성">WOMEN</a></li>
                                <li><a href="아동">KIDS</a></li>
                            </ul>
                            </li>
                
                
                            <li><a href="" class="font-accent">스포츠신발</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            <li><a href="" class="font-accent">의류</a>                    
                            <ul class="sub-menu">
                                <li><a href="">NEW REALEASES</a></li>
                                <li><a href="">MEN</a></li>
                                <li><a href="">WOMEN</a></li>
                                <li><a href="">KIDS</a></li>
                            </ul>
                           </li>
                
                            <li><a href="" class="font-accent">스포츠</a>
                                <ul class="sub-menu">
                                    <li><a href="">NEW REALEASES</a></li>
                                    <li><a href="">MEN</a></li>
                                    <li><a href="">WOMEN</a></li>
                                    <li><a href="">KIDS</a></li>
                                </ul>
                            </li>
                            
                        </ul>
                    </div>

                </ul>
            </div>
            <form class="logo" style="margin-top: 15px" action="/shop/proview" id="searchForm">
                    <input type="text" placeholder="검색" class="search" name="keyword" value="${cri.keyword }">
                        <a href="" id="search">
                            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                                <path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                              </svg>
                        </a>
                        <input type="hidden" name="pageNum" value="1" />
            			<input type="hidden" name="amount" value="12" />
            </form>
        </div>
        <script>
        
        $(function(){
        	
        let searchForm = $("#searchForm");
        $("#search").on("click",function(e){
        	e.preventDefault();
        	searchForm.submit();
        })
        

        
        
        })
        
        
        
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

