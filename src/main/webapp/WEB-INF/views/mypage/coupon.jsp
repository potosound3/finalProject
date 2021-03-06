<jsp:include page="/WEB-INF/views/common/header.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>CSS</title>
    <style>
      #jb-container {
        width: 95%;
        margin: 0px auto;
        padding: 50px 10px 10px 10px;
        /* border: 1px solid #bcbcbc; */
      }
      #benefit-box{
         text-align: center;
      }
      #coupon-box{
         border: 3px solid #E6E6E6; 
         width: 80%;
         display: table;
         display: inline-block;
      }
      #coupon-box li{     
         font-size : 20px;   
         float: left;
         list-style: none;
         margin-left:40px;
         text-align: center;
         width:260px; height:199px;
         background:#f6f6f6;   color:black; 
         
      }
      #coupon-box li a span{
         display: block;
      }    
      .member-Info {
        font-size : 20px; 
        display: table-cell;
    	width: 30%;
    	padding: 20px 0 20px 0;
    	text-align: center;
    	vertical-align: middle;
    	background: #f7f9f8;
      }
      .member-Info2 {     
     	display: table-cell;
    	width: 69%;
    	vertical-align: middle;
    	background: #ffffff;
      }         
      #jb-content {
        width: 85%;
        padding: 20px;
        margin-bottom: 20px;
        float: right;
      }
      #jb-bottom {
        clear: both;
        padding: 20px;
      }
      .search-date {
         width: 70%;
         padding: 30px 20px 30px;
         margin : auto;
         float: center;
         background-color: #F8F8F8;
      }
      .btn-search {   /* 나중에 추가할 버튼양식 */
       display: inline-block;
       margin-left: 30px;
       width: 103px;
       height: 36px;
       line-height: 36px;
       background-color: #606060;
       font-size: 14px;
       color: white;
       vertical-align: top;
       text-align: center;
      }
      #coupon-table {
        border-collapse: collapse;
        width: 100%;
      }
      #coupon-table th {
      border-bottom: 1px solid #ddd;
      background: #f6f6f6;
      padding: 15px 20px; 
         font-weight: bold;
       font-size: 20px;
       vertical-align: middle;
       border-bottom: 1px solid #e0e0e0;
       background: #f6f6f6;
      }
      #coupon-table td {
           padding: 15px 20px; 
        vertical-align: middle;     
        font-size: 15px;     
           border-bottom: 1px solid #ddd;
      }
      
      div.vertical-line{
         height: 200px;
         float: left; 
         border: 1px solid #F8F8F8; /* This is default border style for <hr> tag */
         background-color: #F8F8F8;
       }
    
    </style>
  </head>
  <body>
  
    <div id="jb-container">
    <jsp:include page="/WEB-INF/views/common/mypageSidebar.jsp" />
      <div id="jb-content">
        <h3>나의 혜택</h3>
        <hr>
        <br>
        <div id="benefit-box">
        <div id="coupon-box">
        <div class="member-Info">
        <span>${id }님의</span><br/>
              <span>혜택 내역입니다.</span><br/> 
        </div>
        <div class="member-Info2">
        <ul>
           <li><br>
              <span>
              <img src="/finalProject/resources/mart/images/memberCoupon.png">
              </span><br>
              <span>사용가능쿠폰</span><br><br>
              ${couponCount }장
           </li>
           <div class="vertical-line"></div>
           <li><br>
              <span>
              <img src="/finalProject/resources/mart/images/memberPoint.png">
              </span><br>
              <span>보유적립금</span><br><br>
              <fmt:formatNumber value="${myPoint }" pattern="###,###,###"/>원
           </li>
        </ul>
        </div>
        </div>
        </div>
        <br><br>
       
        <hr><br>
        <div class="search-date">
               
              <form id="couponSearch" name="couponSearch">
		      <label for="UserCheckIN">조회기간 </label>&nbsp;&nbsp;&nbsp;
		      <input type="date" name="fromDate" id="fromDate">&nbsp;&nbsp;~&nbsp;&nbsp;
		      <label for="UserCheckOut"></label> 
		      <input type="date" name="toDate" id="toDate">&nbsp;&nbsp;
		      <input type="button" id="SearchButton" class="btn-search" value="조회하기"></button>
		      </form>
        </div>
         <br><br><hr><br>
    
        <div id="content-detail2">   
        <div class="w3-bar w3-black">
        <button class="w3-bar-item w3-button" onclick="openCoupon('사용가능한 쿠폰')">사용가능한 쿠폰</button>
       <button class="w3-bar-item w3-button" onclick="openCoupon('사용불가능한 쿠폰')">사용불가능한 쿠폰</button>
      </div>
      <div id="couponDateList">
      <div id="사용가능한 쿠폰" class="coupon">
      <br/>
         <table id="coupon-table">
         <thead>
       <tr>
          <th>쿠폰번호</th>
          <th>쿠폰명</th>
          <th>혜택</th>
          <th>유효기간</th>
          <th>발급일</th>
        </tr>
      </thead>        
        <tbody>
        <c:forEach var="coupon" items="${couponList }">
        <c:if test="${coupon.couponUsed == 0 }">
        <tr>
          <td>${coupon.ucouponNo }</td>
          <td>${coupon.coupon.couponTitle }</td>
          <td>${coupon.coupon.couponDiscount }% 할인쿠폰</td>
          <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${coupon.coupon.couponEdate }"/></td>
          <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${coupon.coupon.couponSdate }"/></td>
        </tr>    
        </c:if> 
        </c:forEach>       
        </tbody>
      </table>
      </div>

      <div id="사용불가능한 쿠폰" class="coupon" style="display:none">
       <br/>
        <table id="coupon-table">
         <thead>
       <tr>
          <th>쿠폰번호</th>
          <th>쿠폰명</th>
          <th>혜택</th>
          <th>유효기간</th>
          <th>발급일</th>
        </tr>
      </thead>
        <tbody>        
        <c:forEach var="coupon" items="${couponList }">
        <c:if test="${coupon.couponUsed == 1 }">
        <tr>
          <td>${coupon.ucouponNo }</td>
          <td>${coupon.coupon.couponTitle }</td>
          <td>${coupon.coupon.couponDiscount }% 할인쿠폰</td>
          <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${coupon.coupon.couponEdate }"/></td>
          <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${coupon.coupon.couponSdate }"/></td>
        </tr>                    
        </c:if>
        </c:forEach>
        </tbody>
      </table>
      </div>
         
        </div>        
      </div>
</div>     
      <div id="jb-bottom">
        <br/>
      </div>
</div>
</body>
<script src="/finalProject/resources/admin/vendor/jquery/jquery.min.js"></script>
<script type="text/javascript">
var today = new Date();
var dd = today.getDate();
var mm = today.getMonth()+1; //January is 0!
var yyyy = today.getFullYear();
 if(dd<10){
        dd='0'+dd
    } 
    if(mm<10){
        mm='0'+mm
    } 

today = yyyy+'-'+mm+'-'+dd;
document.getElementById("toDate").setAttribute("max", today);



function openCoupon(couponUsed) {
     var i;
     var x = document.getElementsByClassName("coupon");
     for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";
     }
     document.getElementById(couponUsed).style.display = "block";
   }
   

$('#SearchButton').on('click', function(){
	/* alert($("#searchgogo").serialize()) */
 	$( '#couponDateList').empty();
	$.ajax({
		url : "couponSearch.action",
		type: "POST",
		data: $("#couponSearch").serialize(),
		success: function (data) {			
			$('#couponDateList').append(data);
		},
		error: function () {
			alert("안된다...");
		}
		
	});
	
});
 
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />