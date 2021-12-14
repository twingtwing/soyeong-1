<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#cs-table-SC div.tui-grid-cell-content {
		text-align: center;
	}
</style>
</head>
<body>
	<div class="content-body">
	
			<!-- customerSerivce.js에 있음 -->

            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="admin.do">Main</a></li>
                        <li class="breadcrumb-item active"><a href="questionVList.do">The Sound of Customers</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
                <div class="row mb-3 ml-2">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="d-inline">Customer Service</h4>
                            <p class="text-muted">고객과 관련된 서비스를 관리하는 페이지 입니다.</p>
                            <p class="text-muted">The Voice of Customer page</p>
                        </div>
                    </div>
                </div>
                
                <div class="row m-2">
				<div class="card col-12">
					<div class="card-body">
						<div class="card-title pb-2 pt-1">
							<h4>The Sound of Customers</h4>
						</div>
						<div id="cs-table-SC" class="table-responsive"></div>
					</div>
				</div>
			</div>
        </div>
	</div>
    <!-- #/ container -->
	<script type="text/javascript">
		var dataSC = JSON.parse('${voices}');  
		
		for(var i = 0; i < dataSC.length; i++){
			if(dataSC[i].qFile != undefined){
				dataSC[i].qFile = '<i class="fa fa-download mb-2"></i>';
			}
		}
		
		const gridSC = new tui.Grid({
			el : document.getElementById('cs-table-SC'),
			data : dataSC,
			scrollX : false,
			scrollY : false,
			minBodyHeight : 30,
			rowHeaders: [{
				type : 'rowNum', align : 'center', valign : 'middle'
			}],
			pageOptions : {
				useClient : true,
				perPage : 10
			},
			pagination : true,
			columns : [ {
				header : '말머리',
				name : 'qCategory',
				width : 'auto',
	            minWidth :150
			}, {
				header : '제목',
				name : 'qTitle',
			}, {
				header : '질문자',
				name : 'name',
				width : 'auto',
	            minWidth :100
			}, {
				header : '처리상태',
				name : 'qProcess',
				width : 'auto',
	            minWidth :100
			},{
				header : '파일 포함여부',
				name : 'qFile',
				width : 'auto',
				minWidth :150
			}]
		});

		gridSC.on('click', function(event) {
			location.href = "questionVSelect.do?qNo="+dataSC[event.rowKey].qNo;
		});

		tui.Grid.applyTheme('clean');
	</script>
</body>
</html>