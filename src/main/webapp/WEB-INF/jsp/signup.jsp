<%@include file="includes/header.jsp"%>
<%--formularz rejestracji użytkownika i przycisk sign up
 odsyłający do /create/user.jsp - zmienić nazwy na wczytywane
z languages--%>

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><spring:message code="signup"/></h3>
    </div>
    <div class="panel-body">
        <form:form modelAttribute="signupForm" class="form-horizontal" role="form" action="/signup" method="post">

            <div class="form-group">
                <form:label path="name" for="name" class="col-sm-2 control-label"><spring:message code='name.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='name.placeholder' var="namePlaceholder"/>
                    <form:input path="name" class="form-control" id="name" placeholder="${namePlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="surname" for="surname" class="col-sm-2 control-label"><spring:message code='surname.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='surname.placeholder' var="surnamePlaceholder"/>
                    <form:input path="surname" class="form-control" id="surname" placeholder="${surnamePlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="email" for="email" class="col-sm-2 control-label"><spring:message code='email.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='email.placeholder' var="emailPlaceholder"/>
                    <form:input path="email" type="email" class="form-control" id="email" placeholder="${emailPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="emailConfirm" class="col-sm-2 control-label"><spring:message code='email.confirm.header'/></label>
                <div class="col-sm-10">
                    <spring:message code='email.confirm.placeholder' var="emailConfirmPlaceholder"/>
                    <input type="email" class="form-control" id="emailConfirm" placeholder="${emailConfirmPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="password" for="password" class="col-sm-2 control-label"><spring:message code='password.header'/> </form:label>
                <div class="col-sm-10">
                    <spring:message code='password.placeholder' var="passwordPlaceholder"/>
                    <form:input path="password" type="password" class="form-control" id="password" placeholder="${passwordPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <label for="passwordConfirm" class="col-sm-2 control-label"><spring:message code='password.confirm.header' /></label>
                <div class="col-sm-10">
                    <spring:message code='password.confirm.placeholder' var="passwordConfirmPlaceholder"/>
                    <input type="password" class="form-control" id="passwordConfirm" placeholder="${passwordConfirmPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="role" for="role" class="col-sm-2 control-label"><spring:message code='role.header'/></form:label>
                <div class="col-sm-10">
                    <form:select path="role" class="form-control" id="role">
                        <form:option value="SPORTSMAN"><spring:message code='role.default.header'/></form:option>
                        <form:option value="SPORTSMAN"><spring:message code='role.sportsman.header'/></form:option>
                        <form:option value="GYM_OWNER"><spring:message code='role.gym_owner.header'/></form:option>
                    </form:select>
                </div>
            </div>

            <div class="form-group">
                <form:label path="city" for="city" class="col-sm-2 control-label"><spring:message code='city.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='city.placeholder' var="cityPlaceholder"/>
                    <form:input path="city" class="form-control" id="city" placeholder="${cityPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="street" for="street" class="col-sm-2 control-label"><spring:message code='street.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='street.placeholder' var="streetPlaceholder"/>
                    <form:input path="street" class="form-control" id="street" placeholder="${streetPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="houseNumber" for="houseNumber" class="col-sm-2 control-label"><spring:message code='houseNumber.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='houseNumber.placeholder' var="houseNumberPlaceholder"/>
                    <form:input path="houseNumber" class="form-control" id="houseNumber" placeholder="${houseNumberPlaceholder}"/>
                </div>
            </div>

            <div class="form-group">
                <form:label path="about" for="about" class="col-sm-2 control-label"><spring:message code='about.header'/></form:label>
                <div class="col-sm-10">
                    <spring:message code='about.placeholder' var="aboutPlaceholder"/>
                    <form:textarea path="about" class="form-control" rows="3" placeholder="${aboutPlaceholder}"></form:textarea>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <div class="checkbox">
                        <form:label path="termsAcceptance">
                            <form:checkbox path="termsAcceptance" id="termsAcceptance"/> <spring:message code='termsAcceptance.header'/>
                        </form:label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
                    <form:button type="submit" class="btn btn-default"><spring:message code='signup'/></form:button>
                </div>
            </div>

        </form:form>
    </div>
</div>
<%@include file="includes/footer.jsp"%>