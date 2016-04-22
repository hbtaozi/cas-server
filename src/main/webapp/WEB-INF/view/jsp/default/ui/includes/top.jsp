<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License.  You may obtain a
    copy of the License at the following location:

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.

--%>
<!DOCTYPE html>

<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html lang="zh_cn">
<head>
  <meta charset="UTF-8" />
  
  <title>统一登录</title>
  
  <spring:theme code="standard.custom.css.file" var="customCssFile" />
  <link rel="stylesheet" href="<c:url value="${customCssFile}" />" />
  <link rel="icon" href="<c:url value="/favicon.ico" />" type="image/x-icon" />
  
  <!--[if lt IE 9]>
    <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.6.1/html5shiv.js" type="text/javascript"></script>
  <![endif]-->

   <script type="text/javascript" src="<c:url value="/js/jquery-2.0.0.min.js" />"></script>
    <script type="text/javascript" src="<c:url value="/js/jquery-ui-1.8.2.custom.min.js" />"></script>

    <%--
        JavaScript Debug: A simple wrapper for console.log
        See this link for more info: http://benalman.com/projects/javascript-debug-console-log/
    --%>
    <!--script type="text/javascript" src="https://github.com/cowboy/javascript-debug/raw/master/ba-debug.min.js"></script-->

    <spring:theme code="cas.javascript.file" var="casJavascriptFile" text="" />
    <script type="text/javascript" src="<c:url value="${casJavascriptFile}" />"></script>

    <script>
        function toLogin(url)
        {
          window.open(url,"TencentLogin","width=450,height=320,menubar=0,scrollbars=1,resizable=1,status=1,titlebar=0,toolbar=0,location=1");
        }
   </script>
</head>
