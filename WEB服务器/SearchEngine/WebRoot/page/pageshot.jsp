<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-CN">
  <head>
    <title>快照</title>
	
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->

  </head>
  
  <body onload="init_frm()">
  	<div id="shotinfo" class="shotinfo"></div>
  	<div id="pagecontent" class="pagecontent"></div>
  </body>
  <script src="../js/jquery-1.9.0.min.js"></script>
  <script src="../js/base64.js"></script>

  <script>
	  function getQueryString(name) {
	    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i');
	    var r = window.location.search.substr(1).match(reg);
	    if (r != null) {
	        return unescape(r[2]);
	    }
	    return null;
	}
     //初始化页面           
     function init_frm(){
     	//alert(getQueryString("id"));
		$.ajax({       
              type:"post",
  			  url:"../handlers/pageShot?id="+getQueryString("id"),// 跳转到 action 
  			  contentType:"application/json;charset=utf-8",						  				
			  success:function(json){
				 var obj = eval(json);
		         if (obj != "") {
					 document.title=obj[0].title+"_快照";
					 var fetchtime = obj[0].fetchTime;
					 //alert(fetchtime);
					 var str = "<h3><font color='#af00'>该快照生成时间为:"+fetchtime+"</font></h3><hr>";
					 $("#shotinfo").append(str);
					 var content = obj[0].content;
					 content = utf8to16(base64decode(content));
					 //alert(content);
					 $("#pagecontent").append(content);
		         }/*if (obj != "") */
		       },
		       error:function(json){
		       var obj = eval(json);
				 alert(obj);
		       }
		       
		  });      
     }
  </script>
</html>
