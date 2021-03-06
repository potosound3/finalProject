<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/adminSidebar.jsp" />

<!-- Page Content -->
<div id="page-content-wrapper">

	<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
		<button class="btn btn-primary" id="menu-toggle">Toggle Menu</button>

		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item active">
              <a class="nav-link" href="/finalProject/admin">관리자Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="/finalProject">이지쿡</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                상품관리
              </a>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="/finalProject/admin/product">상품목록</a>
                <a class="dropdown-item" href="/finalProject/admin/product/write">상품등록</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
          </ul>
        </div>
	</nav>
	
	<div class="w3-container w3-center ">
		<h2>상품 수정</h2>

		<form method="post" action="" name="writeForm" enctype="multipart/form-data">
			<table class="w3-table-all" style="width:50%;">
				<tr>
					<td width="70" align="center">상품명</td>
					<td width="330"><input type="text" size="40" maxlength="50" name="productName" value="${product.productName}"></td>
				</tr>
				<tr>
					<td width="70" align="center">상품번호</td>
					<td width="330">${product.productNo}</td>
				</tr>
				<tr>
					<td width="70" align="center">상품내용</td>
					<td width="330"><textarea name="productDetail" rows="13" cols="40">${product.productDetail}</textarea>
					</td>
				</tr>
				<tr>
					<td width="70" align="center">사 진</td>
					<td width="330"><input type="file" size="40" maxlength="30" name="file"><br>
					(기존 파일: ${product.productImage})</td>
				</tr>
				<tr>
					<td width="70" align="center">상품가격</td>
					<td width="330"><input size="5" maxlength="6" name="productPrice" value="${product.productPrice}"> (원)</td>
				</tr>
				<tr>
					<td width="70" align="center">중 량</td>
					<td width="330"><input size="2" maxlength="3" name="productAmount" value="${product.productAmount}"> (g)</td>
				</tr>
				<tr>
					<td width="70" align="center">조리시간</td>
					<td width="330"><input size="2" maxlength="3" name="productTime" value="${product.productTime}"> (분)</td>
				</tr>
				<tr>
					<td colspan=2 align="center">
						<input type="submit" value="수정하기">
						<input type="button" value="뒤로가기" OnClick="javascript:history.back()">
					</td>
				</tr>
			</table>
		</form>
	</div>

</div>
<!-- /#wrapper -->

<!-- Bootstrap core JavaScript -->
<script src="/finalProject/resources/admin/vendor/jquery/jquery.min.js"></script>
<script src="/finalProject/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/finalProject/resources/js/ajax.js"></script>

<script>
	function categoryCount() {
		const cate = document.querySelector("#cate");
		const productNo = document.writeForm.productNo;
		
		let xhttp = new XMLHttpRequest();
		let num = document.writeForm.category.value;
		let category = "?category=" + encodeURIComponent(num);
		xhttp.open("GET", "write/count" + category);
		xhttp.send();
		
		xhttp.onreadystatechange = function () {
			if (this.readyState == 4 && this.status == 200) {
				let count = this.responseText;
				count = count < 10? 0 + count : count;
				cate.innerHTML = "<input type='hidden' name='productNo' value='" + num + (count) + "'>" + num + (count);
			}
		};
	}
	
	
</script>

<!-- Menu Toggle Script -->
<script>
	$("#menu-toggle").click(function(e) {
		e.preventDefault();
		$("#wrapper").toggleClass("toggled");
	});
</script>

</body>
</html>