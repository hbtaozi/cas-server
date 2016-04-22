<%@ page import="com.cas.authentication.CasConstants" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<html>
<jsp:directive.include file="includes/top.jsp" />
<body id="cas">
	<script>
	function changeImg(authImgId)
	{
		authImgId = document.getElementById(authImgId);
		authImgId.src="auth_image.jsp?rnd="+ Math.random();
	}
	if(self.frameElement && self.frameElement.tagName=="IFRAME"){
        // 页面在iframe中时处理
        top.location.href=self.frameElement.src;
    }
	</script>
    <div style="height:100px;" align="right">
      <div class="sidebar-content">
        <div id="list-languages">
          <%final String queryString = request.getQueryString() == null ? "" : request.getQueryString().replaceAll("&locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]|^locale=([A-Za-z][A-Za-z]_)?[A-Za-z][A-Za-z]", "");%>
          <c:set var='query' value='<%=queryString%>' />
          <c:set var="xquery" value="${fn:escapeXml(query)}" />

          <c:choose>
            <c:when test="${not empty requestScope['isMobile'] and not empty mobileCss}">
              <form method="get" action="login?${xquery}">
                <select name="locale">
                  <option value="en">English</option>
                  <option value="zh_CN">Chinese (Simplified)</option>
                  <option value="zh_TW">Chinese (Traditional)</option>
                </select>
                <input type="submit" value="Switch">
              </form>
            </c:when>
            <c:otherwise>
              <c:set var="loginUrl" value="login?${xquery}${not empty xquery ? '&' : ''}locale=" />
              <ul>
                <li class="first"><a href="${loginUrl}en">English</a></li>
                <li><a href="${loginUrl}zh_CN">Chinese (Simplified)</a></li>
                <li><a href="${loginUrl}zh_TW">Chinese (Traditional)</a></li>
              </ul>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>

    <div align="center">
        <div class="box" id="login" align="center">
          <form:form method="post" id="fm1" commandName="${commandName}" htmlEscape="true">

            <form:errors path="*" id="msg" cssClass="errors" element="div" htmlEscape="false" />

            <h2><spring:message code="screen.welcome.instructions" /></h2>

            <section class="row">
              <spring:message code="screen.welcome.label.loginway" />
                  <select name="authWay" id="authWay">
                        <option value="normal">Normal</option>
                        <option value="mobile">Mobile</option>
                        <option value="email">Email</option>
                  </select>
            </section>

            <section class="row">
              <spring:message code="screen.welcome.label.netid" />
              <c:choose>
                <c:when test="${not empty sessionScope.openIdLocalId}">
                  <strong>${sessionScope.openIdLocalId}</strong>
                  <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
                </c:when>
                <c:otherwise>
                  <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
                  <form:input cssClass="required" cssErrorClass="error" id="username" size="25" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="off" htmlEscape="true" />
                </c:otherwise>
              </c:choose>
            </section>

            <section class="row">
              <spring:message code="screen.welcome.label.password" />
              <%--
              NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
              "autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
              information, see the following web page:
              http://www.technofundo.com/tech/web/ie_autocomplete.html
              --%>
              <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
              <form:password cssClass="required" cssErrorClass="error" id="password" size="25" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
            </section>

			<section class="row">
              <spring:message code="screen.welcome.label.authcode" />
              <input id="yzm" name="<%=CasConstants.AUTH_CODE_FIELD_NAME%>"  tabindex="2" type="text" value="" size="5">
              <span style="vertical-align: middle"><img id="authImg" src="${pageContext.request.contextPath}/auth_image.jsp"> </span>
              <a href="#" onclick="changeImg('authImg')"><spring:message code="screen.welcome.button.authCode.refresh" /></a>
            </section>

            <section class="row check">
              <input id="warn" name="warn" value="true" tabindex="3" accesskey="<spring:message code="screen.welcome.label.warn.accesskey" />" type="checkbox" />
              <label for="warn"><spring:message code="screen.welcome.label.warn" /></label>
            </section>

            <section class="row btn-row">
              <input type="hidden" name="lt" value="${loginTicket}" />
              <input type="hidden" name="execution" value="${flowExecutionKey}" />
              <input type="hidden" name="_eventId" value="submit" />

              <input class="btn-submit" name="submit" accesskey="l" value="<spring:message code="screen.welcome.button.login" />" tabindex="4" type="submit" />
              <input class="btn-reset" name="reset" accesskey="c" value="<spring:message code="screen.welcome.button.clear" />" tabindex="5" type="reset" />
            </section>
            <section class="row btn-row">
                 <a href="#" onclick='toLogin("${QQClientUrl}")'><img src='<c:url value="/images/Connect_logo_1.png" />'></a>
            </section>
          </form:form>
        </div>
    </div>

<!-- br />
<a href="${FacebookClientUrl}">Authenticate with Facebook</a> <br />
<br />
<a href="${TwitterClientUrl}">Authenticate with Twitter</a><br />
<br />
<a href="${CasOAuthWrapperClientUrl}">Authenticate with another CAS server using OAuth v2.0 protocol</a><br />
<br />
<a href="${CasClientUrl}">Authenticate with another CAS server using CAS protocol</a><br />
<br />
<a href="${Saml2ClientUrl}">Authenticate with a SAML provider</a><br />
<br / -->

 </div>
<jsp:directive.include file="includes/bottom.jsp" />

</body>
</html>



