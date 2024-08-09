<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Demat Account</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> 
<link rel='stylesheet' type='text/css' media='screen' href='<%=request.getContextPath()%>/css/landingPage.css'>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">


<script type="text/javascript"> function preback() { window.history.forward(); } setTimeout("preback()", 0); window.onunload = function () { null }; </script>
</head>
<body>
	<div class="header-container">
		<h1>BANKING</h1>
	</div>
	 
	<div class="header_col_1 fas_align_two_buttons">
       <a class="fas fa-arrow-left align-left" href="demattoaccount"></a>
       <a class="fas align-right" href="logout">LOGOUT</a>
    </div>
	
	<div class="container">
			
			<div id="Account_type">
				<h2>Demat Account</h2>
			</div>
			
			<div class="inner-container">  
		
				<ul class = "personal-info">
					<li>
						<label>Account Number:</label>
						<span>${d.getAcc_no()}</span>
					</li>
						<li>
						<label>Original Total Amount:</label>
						<c:if test="${not empty ind}">
							<span>&#8377 ${d.getOriginal_total_amount()}</span>
						</c:if>
						<c:if test="${not empty usd}">
							<span>&#36 ${d.getOriginal_total_amount()}</span>
						</c:if>
						<c:if test="${not empty euro}">
							<span>&#8364 ${d.getOriginal_total_amount()}</span>
						</c:if>	
					</li>
					<li>
						<label>Current Market Amount:</label>
						<%-- <span>${d.getMarket_total_amount()}</span> --%>
						<c:if test="${not empty ind}">
							<span>&#8377 ${d.getMarket_total_amount()}</span>
						</c:if>
						<c:if test="${not empty usd}">
							<span>&#36 ${d.getMarket_total_amount()}</span>
						</c:if>
						<c:if test="${not empty euro}">
							<span>&#8364 ${d.getMarket_total_amount()}</span>
						</c:if>	
					</li>
				</ul>
				
				<div class="clr"></div>
			
			</div>
		
		<div class = "tth">
			<h2>User Stocks</h2>
		</div>	
		<div class = "table_container table-sortable" id="table1">
		
		<input id="sortfield1" type="hidden" value ="${sortfield1}" />
		<input id="sortdir1" type="hidden" value ="${sortdir1}" />
		
		<div class="table-search">
			<div class="search-wrapper">
				<input id="table-searchbar1" class="table-searchbar" type="text" value="${keyword1}" />
				<a id="cancel-search-table1" data-visible="false" class="cancel-search-table" href="Rdemat?table=1"><i class="fa fa-times"  aria-hidden="true"></i></a>
			</div>
			<a id="search-table1" data-visible="true" class="search-table" href = "javascript:;" onclick = "this.href='Rdemat?table=1&keyword1=' + document.getElementById('table-searchbar1').value"><i class="fa fa-search"  aria-hidden="true"></i></a>
		</div>
		
		<table >
			<tr id="header_row">
				<th id="stock_id"><a id="stock_id_anchor1" style="text-decoration:none; color:white;" href="Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=stock_id&sortdir1=${revsortdir1}">Stock ID</a></th>
				<th id="stock_name"><a id="stock_name_anchor1" style="text-decoration:none; color:white;" href="Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=stock_name&sortdir1=${revsortdir1}">Stock Name</a></th>
				<th id="original_price"><a id="original_price_anchor1" style="text-decoration:none; color:white;" href="Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=original_price&sortdir1=${revsortdir1}">Original Price</a></th>
				<th id="current_market_price"><a id="current_market_price_anchor1" style="text-decoration:none; color:white;" href="Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=current_market_price&sortdir1=${revsortdir1}">Market Price</a></th> 
				<th id="no_stocks"><a id="no_stocks_anchor1" style="text-decoration:none; color:white;" href="Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=no_stocks&sortdir1=${revsortdir1}">Number of Stocks</a></th>
				<th>Action</th>
			</tr>
			<c:forEach var="s" items="${sd}">
			<tr>
				<td data-cell="Stock Id">${s.stock_id}</td>
				<td data-cell="Stock Name">${s.stock_name}</td>
				<c:if test="${not empty ind}">
					<td data-cell="Original Price"><span>&#8377 </span>${s.original_price}</td>
				</c:if>
				<c:if test="${not empty usd}">
					<td data-cell="Original Price"><span>&#36 </span>${s.original_price}</td>
				</c:if>
				<c:if test="${not empty euro}">
					<td data-cell="Original Price"><span>&#8364 </span>${s.original_price}</td>
				</c:if>	
				
				<c:if test="${not empty ind}">
					<td data-cell="Market Price"><span>&#8377 </span>${s.market_price}</td>
				</c:if>
				<c:if test="${not empty usd}">
					<td data-cell="Market Price"><span>&#36 </span>${s.market_price}</td>
				</c:if>
				<c:if test="${not empty euro}">
					<td data-cell="Market Price"><span>&#8364 </span>${s.market_price}</td>
				</c:if>	
				
				<td data-cell="No of Stocks">${s.no_stocks}</td>
				
				<td data-cell="#"><a class="link" href="sellstock/${d.getAcc_no()}/${s.stock_name}/${s.sno}">SELL</a></td>
			</tr>
			</c:forEach>
			
		</table>
			
		</div>
		<div class="center">	
			<div class="pagination">
			
				<c:if test="${pgno1 > 1}">
						<a href = "Rdemat?table=1&pgno1=0&pagesize1=${pagesize1}&sortfield1=${sortfield1}&sortdir1=${sortdir1}&keyword1=${keyword1}">First</a>
				</c:if>
				
				<c:if test="${pgno1 > 0}">
						<a href = "Rdemat?table=1&pgno1=${pgno1-1}&pagesize1=${pagesize1}&sortfield1=${sortfield1}&sortdir1=${sortdir1}&keyword1=${keyword1}">&laquo;</a>
				</c:if>
				
				
			  <c:forEach var = "i" begin = "${begin1}" end ="${stop1}">
			  
			  	<c:if test="${pgno1 == i}">
						<a href = "Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=${sortfield1}&sortdir1=${sortdir1}&keyword1=${keyword1}" class="active"> ${i+1}</a>
				</c:if>
				
				<c:if test="${pgno1 !=  i}">
						<a href = "Rdemat?table=1&pgno1=${i}&pagesize1=${pagesize1}&sortfield1=${sortfield1}&sortdir1=${sortdir1}&keyword1=${keyword1}" class=""> ${i+1}</a>
				</c:if>
				
				</c:forEach>
				
				<c:if test="${pgno1 < last_page1}">
						<a href = "Rdemat?table=1&pgno1=${pgno1+1}&pagesize1=${pagesize1}&sortfield1=${sortfield1}&sortdir1=${sortdir1}&keyword1=${keyword1}">&raquo;</a>
				</c:if>
				
			<c:if test="${pgno1 < last_page1}">
						<a href = "Rdemat?table=1&pgno1=${last_page1}&pagesize1=${pagesize1}&sortfield1=${sortfield1}&sortdir1=${sortdir1}&keyword1=${keyword1}">Last</a>
			  </c:if>	
			  
			</div>
			<div class="infopart">
			
				<span id="rginfopart">Page Size:</span>
				<input id="rftextbox" type ="text" value="${pagesize1}"/> 
				<a href = "javascript:;" onclick = "this.href='Rdemat?table=1&pagesize1='+document.getElementById('rftextbox').value +'&keyword1=' + document.getElementById('table-searchbar1').value +'&sortfield1=${sortfield1}&sortdir1=${sortdir1}'" >Change</a>
			</div>
		</div>
		
		<div id="pagination-mobile1" class="pagination-mobile">
			
			<c:choose>
			    <c:when test="${pagesize1 < 10}">
			        <a href="Rdemat?table=1&pagesize1=${pagesize1+10}">Show More<span class="fas fa-caret-down"></span></a>
			        <br />
			    </c:when>    
			    <c:otherwise>
			        <a href="Rdemat?table=1&pagesize1=${pagesize1-10}">Show Less<span class="fas fa-caret-up"></span></a> 
			        <br />
			    </c:otherwise>
			</c:choose>
			
		</div>

		
		<br>
		
		<br>
		<div class = "tth">
			<h2>New Stocks</h2>
		</div>	
		<div class = "table_container table-sortable" id="table2">
		<input id="sortfield2" type="hidden" value ="${sortfield2}" />
		<input id="sortdir2" type="hidden" value ="${sortdir2}" />
		<div class="table-search">
			
			<div class="search-wrapper">
				<input id="table-searchbar2" class="table-searchbar" type="text" value="${keyword2}" />
				<a id="cancel-search-table2" data-visible="false" class="cancel-search-table" href="Rdemat?table=2"><i class="fa fa-times"  aria-hidden="true"></i></a>
			</div>
			
			<a id="search-table2" class="search-table"  data-visible="true" href = "javascript:;" onclick = "this.href='Rdemat?table=2&keyword2=' + document.getElementById('table-searchbar2').value"><i class="fa fa-search" aria-hidden="true"></i></a>
		</div>
		
		<table>
			<tr id="header_row">
				<th id="stock_id_2"><a id="stock_id_anchor2" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Rdemat?table=2&pgno2=${i}&pagesize2=${pagesize2}&sortfield2=stock_id&sortdir2=${revsortdir2}">Stock Id</a></th>
				<th id="stock_name_2"><a id="stock_name_anchor2" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Rdemat?table=2&pgno2=${i}&pagesize2=${pagesize2}&sortfield2=stock_name&sortdir2=${revsortdir2}">Stock Name</a></th>
				<th id="stock_price_2"><a id="stock_price_anchor2" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Rdemat?table=2&pgno2=${i}&pagesize2=${pagesize2}&sortfield2=stock_price&sortdir2=${revsortdir2}">Stock Pirce</a></th>
				<th id="no_of_avl_stocks_2"><a id="no_of_avl_stocks_anchor2" title="Align in DESC Order" style="text-decoration:none; color:white;" href="Rdemat?table=2&pgno2=${i}&pagesize2=${pagesize2}&sortfield2=no_of_avl_stocks&sortdir2=${revsortdir2}">Number of Stocks</a></th>
				<th>Action</th>
			</tr>
			<c:forEach var="ns" items="${nsd}">
			<tr>	
				<td data-cell="Stock Id">${ns.stock_id}</td>
				<td data-cell="Stock Name">${ns.stock_name}</td>
				
				<c:if test="${not empty ind}">
					<td data-cell="Stock Price"><span>&#8377 </span>${ns.stock_price}</td>
				</c:if>
				<c:if test="${not empty usd}">
					<td data-cell="Stock Price"><span>&#36 </span>${ns.stock_price}</td>
				</c:if> 
				<c:if test="${not empty euro}">
					<td data-cell="Stock Price"><span>&#8364 </span>${ns.stock_price}</td>
				</c:if>	
		
				<td data-cell="No of Stocks">${ns.no_of_avl_stocks}</td>
			
				<td data-cell="#"><a class="link" href="buystock/${ns.stock_name}/${ns.stock_id}/${d.getAcc_no()}">BUY</a></td>
			</tr>
			</c:forEach> 
		</table>
	
	</div>
		<div class="center">	
			<div class="pagination">
			
				<c:if test="${pgno2 > 1}">
						<a href = "Rdemat?table=2&pgno2=0&pagesize2=${pagesize2}&sortfield2=${sortfield2}&sortdir2=${sortdir2}&keyword2=${keyword2}">First</a>
				</c:if>
	
				<c:if test="${pgno2 > 0}">
						<a href = "Rdemat?table=2&pgno2=${pgno2-1}&pagesize2=${pagesize2}&sortfield2=${sortfield2}&sortdir2=${sortdir2}&keyword2=${keyword2}">&laquo;</a>
				</c:if>
				
				
			  <c:forEach var = "i" begin = "${begin2}" end ="${stop2}">
			  
			  	<c:if test="${pgno2 == i}">
						<a href = "Rdemat?table=2&pgno2=${i}&pagesize2=${pagesize2}&sortfield2=${sortfield2}&sortdir2=${sortdir2}&keyword2=${keyword2}" class="active"> ${i+1}</a>
				</c:if>
				
				<c:if test="${pgno2 !=  i}">
						<a href = "Rdemat?table=2&pgno2=${i}&pagesize2=${pagesize2}&sortfield2=${sortfield2}&sortdir2=${sortdir2}&keyword2=${keyword2}" class=""> ${i+1}</a>
				</c:if>
				
				</c:forEach>
			  
				<c:if test="${start2+end2 <= total2}">
						<a href = "Rdemat?table=2&pgno2=${pgno2+1}&pagesize2=${pagesize2}&sortfield2=${sortfield2}&sortdir2=${sortdir2}&keyword2=${keyword2}">&raquo;</a>
				</c:if>
				
					<c:if test="${pgno2 < last_page2}">
						<a href = "Rdemat?table=2&pgno2=${last_page2}&pagesize2=${pagesize2}&sortfield2=${sortfield2}&sortdir2=${sortdir2}&keyword2=${keyword2}">Last</a>
			  </c:if>	
			  
			</div>
		<div class="infopart">
			
				<span id="rginfopart">Page Size:</span>
				<input id="rftextbox2" type ="text" value="${pagesize2}"/> 
				<a href = "javascript:;" onclick = "this.href='Rdemat?table=2&pagesize2='+document.getElementById('rftextbox2').value+'&keyword2=' + document.getElementById('table-searchbar2').value +'&sortfield2=${sortfield2}&sortdir2=${sortdir2}'" >Change</a>
			</div>
		</div>
		<div id="pagination-mobile2" class="pagination-mobile">
			
			<c:choose>
			    <c:when test="${pagesize2 <= 10}">
			        <a href="Rdemat?table=2&pagesize2=${pagesize2+10}">Show More<span class="fas fa-caret-down"></span></a>
			        <br />
			    </c:when>    
			    <c:otherwise>
			        <a href="Rdemat?table=2&pagesize2=${pagesize2-10}">Show Less<span class="fas fa-caret-up"></span></a> 
			        <br />
			    </c:otherwise>
			</c:choose>
			
		</div>
	</div>
	
	<a href="#" class= "to-top">
		<i class="fas fa-chevron-up"></i>
	</a>
	
	<input type="hidden" id="alert_msg" value="${alert_msg}">
	<!-- ----------------------JavaScript------------------ -->
	 <script>
	 	
	 	const msg = document.getElementById("alert_msg").value;
	 		if(msg != 'null'){
	 			alert(msg);
	 		}
	 		
	 	 	const sortfield1 = document.getElementById("sortfield1").value;
		 	const sortdir1 = document.getElementById("sortdir1").value;
		 	 
		 	const myElement1 = document.getElementById(sortfield1);
		 	if(sortfield1 != 'sno'){
		 		myElement1.classList.add("active");
			 		
			 	var indicator1 = sortfield1.concat("_anchor1");
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
		 	
	 	
	 	 	var field = document.getElementById("sortfield2").value;
	 	 	const sortfield2 = field.concat("_2"); 
		 	const sortdir2 = document.getElementById("sortdir2").value;
		 	 
		 	const myElement2 = document.getElementById(sortfield2);
		 	
		 	if(field != 'sno'){
			 	myElement2.classList.add("active");
			 	
			 	var indicator2 = field.concat("_anchor2");
			 	const after_Element2 = document.getElementById(indicator2);
			 	
			 	if(sortdir2 == 'ASC'){
			 		after_Element2.classList.add("th-sort-desc");
			 		after_Element2.title = "Align in DESC Order";
			 	}
			 	
			 	if(sortdir2 == 'DESC'){
			 		after_Element2.classList.add("th-sort-asc");
			 		after_Element2.title = "Align in ASC Order";
			 	}  
		 	}
	 </script>
	
	<input type = "hidden" name="ScrollPosition" id="ScrollPosition" value="${ScrollPosition}">
	<input type="hidden" id="totalrecords1" value="${total1}">
	<input type="hidden" id="totalrecords2" value="${total2}">
	
<script type="text/javascript">
	
	
 	const tablesearchbar1 = document.getElementById("table-searchbar1").value;
 	const cancelIcon1 = document.getElementById("cancel-search-table1");
 	
 	if(tablesearchbar1){
	 		cancelIcon1.setAttribute("data-visible", true);
			cancelIcon1.style.display="inline-block";
	 	}else{
	 		cancelIcon1.setAttribute("data-visible", false);
			cancelIcon1.style.display="none";
	 }

 	const tablesearchbar2 = document.getElementById("table-searchbar2").value;
 	const cancelIcon2 = document.getElementById("cancel-search-table2");
 	
 	if(tablesearchbar2){
 		cancelIcon2.setAttribute("data-visible", true);
		cancelIcon2.style.display="inline-block";
 	}else{
 		cancelIcon2.setAttribute("data-visible", false);
		cancelIcon2.style.display="none";
 	}
	
	
	const Scroll = document.getElementById("ScrollPosition").value;
		
		if( Scroll === 'sell_table' ){	
			window.location = "#table1";
		}
		
		if( Scroll === 'buy_table' ){	
			window.location = "#table2";
		}
		
 	const toTop = document.querySelector(".to-top");
	 	
	 	window.addEventListener("scroll", () =>{
	 		if(window.pageYOffset > 100){
	 			toTop.classList.add("active");
	 		}else{
	 			toTop.classList.remove("active");
	 		}
	 	})
	 	
	const totalrecords1 = document.getElementById("totalrecords1").value;
	 	if(totalrecords1 < 10 ){
	 		const paginationmobile1 = document.getElementById("pagination-mobile1");
	 		paginationmobile1.style.display = "none";
	 	}
	 	
	 	const totalrecords2 = document.getElementById("totalrecords2").value;
	 	if(totalrecords2 < 10 ){
	 		const paginationmobile2 = document.getElementById("pagination-mobile2");
	 		paginationmobile2.style.display = "none";
	 	}
		
	</script>
	
</body>
</html>