<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel='stylesheet' type='text/css' media='screen' href='<%=request.getContextPath()%>/css/landingPage.css'>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<title>Banking: User Account</title>
<script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script> 
</head>
<body id="body">
	<div class="header-container">
		<h1>BANKING</h1>
	</div>
		
	<div class="header_col_1 fas_align_one_button" >
        <a class="fas align-right" href="logout">LOGOUT</a>
    </div>

	<div class="container">
		<c:if test="${not empty hc}">
		<div id="Account_type">
				<h2>Current Account</h2>
		</div>
		
 		<div class="additional_Links">	
			<form action="todemat" method="post">
				  <input id="hyperlink_button" type="submit" value="Demat Account" />
			</form>
			<hr class="xs-vhr">
			<form action="tooverdraft" method="post">
				  <input id="hyperlink_button" type="submit" value="Overdraft" />
			</form>
		</div>
		
		</c:if>
		
		<c:if test="${not empty hs}">
			<div id="Account_type">
				<h2>Savings Account</h2>
			</div>
		</c:if>
		
		<div class="inner-container">  
		
			<ul class = "personal-info">
				<li>
					<label>Account Number :</label>
					<span>${data.acc_no}</span>
				</li>
				<li>
					<label>Account Type :</label>
					<span>${data.acc_type}</span>
				</li>
				<li>
					<label>Account Status :</label>
					<span>${data.acc_status}</span>
				</li>
				<li>
					<label>IFSC :</label>
					<span>${data.ifsc}</span>
				</li>
				<li>
					<label>Branch :</label>
					<span>${data.branchname}</span>
				</li>
				<li>
					<label>Branch ID:</label>
					<span>${data.branchid}</span>
				</li>
				
				<li>
					<label>Account Balance:</label>
					<c:if test="${not empty ind}">
						<span>&#8377 ${data.acc_balance}</span>
					</c:if>
					<c:if test="${not empty usd}">
						<span>&#36 ${data.acc_balance}</span>
					</c:if>
					<c:if test="${not empty euro}">
						<span>&#8364 ${data.acc_balance}</span>
					</c:if>	
				</li>
			</ul>
			<div class="clr"></div>
		</div>
		
		<div class = "tth">
			<h2>Transaction History</h2>
		</div>
		

	<div class = "table_container table-sortable" id="table">
		
		<input id="sortfield" type="hidden" value ="${sortfield}" />
		<input id="sortdir" type="hidden" value ="${sortdir}" />
		
		<div class="table-search">
			<div class="search-wrapper">
				<input id="table-searchbar" class="table-searchbar" type="text" value="${keyword}" />
				<a id="cancel-search-table" class="cancel-search-table" data-visible="false" href="Raccount"><i class="fa fa-times" aria-hidden="true"></i></a>
			</div>
			<a id="search-table" class="search-table" data-visible="true" href="javascript:;" onclick = "this.href='Raccount?keyword=' + document.getElementById('table-searchbar').value"><i class="fa fa-search"  aria-hidden="true"></i></a>
		</div>
		
		<table>
			
			<tr id="header_row">
				
					<th id ="t_date"><a title="Align in DESC Order" id="t_date_anchor" style="text-decoration:none; color:white;" href="Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=t_date&sortdir=${revsortdir}">Date </a></th>
					<th id="t_id"> <a id="t_id_anchor" title="Align in DESC Order"  style="text-decoration:none; color:white;" href="Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=t_id&sortdir=${revsortdir}">Transaction ID </a></th>
					<th id="pmnt_method"><a id="pmnt_method_anchor" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=pmnt_method&sortdir=${revsortdir}">Payment Method </a></th> 
					<th id="pmnt_type"><a id="pmnt_type_anchor" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=pmnt_type&sortdir=${revsortdir}">Payment Type </a></th>
					<th id= "amnt" ><a id= "amnt_anchor" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=amnt&sortdir=${revsortdir}">Amount </a></th>
		
			</tr>
			
			<c:forEach var="d" items="${td}">
			<tr>	
				<td data-cell="Date">${d.t_date}</td>
				<td data-cell="Transaction ID">${d.t_id}</td>
				<td data-cell="Payment Method ">${d.pmnt_method}</td>
				<td data-cell="Payment Type">${d.pmnt_type}</td>
				<c:if test="${not empty ind}">
					<td data-cell="Amount"><span>&#8377 </span>${d.amnt}</td>
				</c:if>
				<c:if test="${not empty usd}">
					<td data-cell="Amount"><span>&#36 </span>${d.amnt}</td>
				</c:if>
				<c:if test="${not empty euro}">
					<td data-cell="Amount"><span>&#8364 </span>${d.amnt}</td>
				</c:if>
			</tr>
			</c:forEach>
		</table> 
	</div>
	
	<div class="center">	
	
			<div class="pagination">
			
			<c:if test="${pgno > 1}">
					<a href = "Raccount?pgno=0&pagesize=${pagesize}&sortfield=${sortfield}&sortdir=${sortdir}&keyword=${keyword}">First</a>
			</c:if>
		
			<c:if test="${pgno > 0}">
					<a href = "Raccount?pgno=${pgno-1}&pagesize=${pagesize}&sortfield=${sortfield}&sortdir=${sortdir}&keyword=${keyword}">&laquo;</a>
			</c:if>
			 
			  <c:forEach var = "i" begin = "${begin}" end ="${stop}">
			  	<c:if test="${pgno == i}">
						<a href = "Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=${sortfield}&sortdir=${sortdir}&keyword=${keyword}" class="active"> ${i+1}</a>
				</c:if>
				<c:if test="${pgno !=  i}">
						<a href = "Raccount?pgno=${i}&pagesize=${pagesize}&sortfield=${sortfield}&sortdir=${sortdir}&keyword=${keyword}" class=""> ${i+1}</a>
				</c:if>
			  </c:forEach>
			  
			  <c:if test="${pgno < last_page}">
						<a href = "Raccount?pgno=${pgno+1}&pagesize=${pagesize}&sortfield=${sortfield}&sortdir=${sortdir}&keyword=${keyword}">&raquo;</a>
			  </c:if>
				
			   <c:if test="${pgno < last_page}">
						<a href = "Raccount?pgno=${last_page}&pagesize=${pagesize}&sortfield=${sortfield}&sortdir=${sortdir}&keyword=${keyword}">Last</a>
			  </c:if>	
			</div>
			
			<div class="infopart">
				<span id="rginfopart">Page Size:</span>
				<input id="rftextbox" type ="text" value="${pagesize}"/> 
				<a href = "javascript:;" onclick = "this.href='Raccount?pagesize=' + document.getElementById('rftextbox').value +'&keyword=' + document.getElementById('table-searchbar').value +'&sortfield=${sortfield}&sortdir=${sortdir}'" >Change</a>
			</div>
		</div>
		
	<div id="pagination-mobile" class="pagination-mobile">
			
			<c:choose>
			    <c:when test="${pagesize <= 10}">
			        <a href="Raccount?pgno=0&pagesize=${pagesize+10}&keyword=${keyword}">Show More<span class="fas fa-caret-down"></span></a>
			        <br/>
			    </c:when>    
			    <c:otherwise>
			        <a href="Raccount?pgno=0&pagesize=${pagesize-10}&keyword=${keyword}">Show Less<span class="fas fa-caret-up"></span></a> 
			        <br/>
			    </c:otherwise>
			</c:choose>
			
		</div>
	</div>

	<a href="#" class= "to-top">
		<i class="fas fa-chevron-up"></i>
	</a>
	
	<input type="hidden" id="alert_msg" value="${alert_msg}">
	<input type="hidden" id="ScrollPosition" value="${ScrollPosition}">
	<input type="hidden" id="totalrecords" value="${total}">
	
	<!-- ----------------------JavaScript------------------ -->
	 <script>

	 	const tablesearchbar = document.getElementById("table-searchbar").value;
 	 	const cancelIcon = document.getElementById("cancel-search-table");
	 	
 	 	if(tablesearchbar){
 	 		cancelIcon.setAttribute("data-visible", true);
			cancelIcon.style.display="inline-block";
 	 	}else{
 	 		cancelIcon.setAttribute("data-visible", false);
			cancelIcon.style.display="none";
 	 	}
 	 	
	 
	 	const msg = document.getElementById("alert_msg").value;
	 		
	 	if(msg != 'null'){
	 		alert(msg);
	 	}
	 	
 	 	const sortfield1 = document.getElementById("sortfield").value;
	 	const sortdir1 = document.getElementById("sortdir").value;
	 	 
	 	const myElement1 = document.getElementById(sortfield1);
	 	if(sortfield1 != 'sno'){
	 		myElement1.classList.add("active");
		 		
		 	var indicator1 = sortfield1.concat("_anchor");
		 	const after_Element1 = document.getElementById(indicator1);
		 	
		 	if(sortdir1 == 'ASC'){
		 		after_Element1.classList.add("th-sort-desc");
		 		after_Element1.title = "Align in DESC Order";
		 	}
		 	
		 	if(sortdir1 == 'DESC'){
		 		after_Element1.classList.add("th-sort-asc");
		 		after_Element1.title = "Align in ASC Order";
		 	}
	 	}
	 	
	 	const toTop = document.querySelector(".to-top");
	 	
	 	window.addEventListener("scroll", () =>{
	 		if(window.pageYOffset > 100){
	 			toTop.classList.add("active");
	 		}else{
	 			toTop.classList.remove("active");
	 		}
	 	})
	 	
	 	const totalrecords = document.getElementById("totalrecords").value;
	 	if(totalrecords <= 10 ){
	 		const paginationmobile = document.getElementById("pagination-mobile");
	 		paginationmobile.style.display = "none";
	 	}

	 </script>

	<script type="text/javascript">
	
	const Scroll = document.getElementById("ScrollPosition").value;
	if( Scroll === 'true' ){	
		window.location = "#table";
	}
	
	</script>
</body>
</html>