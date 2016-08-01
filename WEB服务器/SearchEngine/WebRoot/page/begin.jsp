<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后. -->
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>搜一下,你就知道</title>
    <link rel="stylesheet" href="../css/common.css"/>
    <link rel="stylesheet" href="../css/yxjay.css"/>     
    <script src="../js/jquery-1.9.0.min.js"></script>
    <script>
      	function check_frm(){
      		var input = $("#searchIpt").val().trim();
      		//alert(input);
      		if(!input || input=="")
      			return false;
      		return true;
      	}
      	     //输入联想模块
      function change() {
    	  var searchIpt = $("#searchIpt").val();
      	  $.ajax({       
              type:"post",
  			  url:"../handlers/searchReminder?strInput="+searchIpt,// 跳转到 action 
  			  contentType:"application/json;charset=utf-8",						  				
			  success:function(json){
				 var obj = eval(json);
				 $("#indexcontent").html(""); //删除原有数据
				 //alert(obj[0].name);
		         if (obj != "") {
		         	var length = $(obj).length >=5?5:$(obj).length;
		             for (var i = 0; i < length; i++) {
		                 $("#indexcontent").append('<div onclick="mousedown(this)">' + obj[i].name + '</div>');
		             }
		             $("#indexcontent").slideDown();
		         }
			  }	
		  });
      }
      //选择其中的提示内容
      function mousedown(object) {
          var a = $(object).text();
          $("#searchIpt").val(a);
          $("#tbcontent").fadeOut();
      }
      //下拉框失去焦点
      function lost() {
          $("#indexcontent").fadeOut();
      }
      		  	   	     			
    </script>
  </head>
  <body>
    <div id="wrapper">
    	<div class="skinBg" style="background-image: url('../img/bg.jpg');"></div>
    	<header id="header">
    		<div class="weather fl">
    			<span class="cityW">
    				<span>厦门：</span>
    				<span>
    					<span class="weatherIcon wI1"></span>
    					<span>23 ~ 31℃</span>
    				</span>
    			</span>
    			<span class="sp">|</span>
    			<span class="pollution">
    				<span>空气质量：83</span>
    				<span class="polutionLevel">良</span>
    			</span>
    			<div class="cityWeather">
    				
    			</div>
    		</div>
    		<nav class="headNavs fr tr">
    			<a href="#"><span class="s-icon s-icon-treasure"></span><span>宝箱</span></a>
    			<a href="#"><span class="s-icon s-icon-skin"></span><span>换肤</span></a>
    			<a href="#"><span class="s-icon s-icon-msg"></span><span>消息</span></a>
    			<a><span class="s-icon s-icon-line"></span></a>
    			<a href="CrawlerWebSetting.html"><span>网页设置</span></a>
    			<!--<a href="javascript:;" class="uname"><span>个人中心</span><span class="user-arrow"></span></a>
    			  <div class="topMenus dn">
    				<span class="arrowTop"></span>
    				<a href="#">个人中心</a>
    				<a href="#">帐号设置</a>
    				<a href="#">搜索设置</a>
    				<a href="#">意见反馈</a>
    				<a href="#">首页教程</a>
    				<a href="#">安全退出</a>
    			</div>-->
    		</nav>
    	</header>
    	<div class="content tc center">
    		<p class="logo"><img width="270" height="129" src="../img/logo_white.png" alt="logo" /></p>
    		<br><br>
    		<nav class="mainNavs" style="margin-left:33%;">
    			<a href="#">网页</a>
    			<a href="#">音乐</a>
    			<a href="#">图片</a>
    			<a href="#">视频</a>
				<a href="#">文档</a>
    			<a href="#">更多&gt;&gt;</a>
    		</nav>
    		<div class="searchBox">
    			<form method="post" action="home.jsp" onsubmit="return check_frm()">
    				<input name="searchIpt" id="searchIpt" type="text" class="searchIpt f14" onkeyup="change()" onblur="lost()" maxlength="20" autocomplete="off"/>
    				<button class="btn" id="search">搜索</a>		
    			</form>
    			
    		</div>
    		<div id="indexcontent" class="indexcontent"></div>
    	</div>

    </div>

    <!--页脚-->
    <div class="footer-class-index">
      <p >©2016  版权所有 Email:yxjay@163.com</p>
    </div>
   
  </body>
</html>