<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Page</title>
<style>
	.register{
		border: 2px solid black;
		width: 20%;
		padding: 30px;
		
	}
	
	.login{
		border: 2px solid black;
		height: 200px;
		width: 350px;
		padding: 30px;
	}
	
	.content{
		display: flex;
		justify-content: space-evenly;
	}
	
	header{
		margin-left: 310px;
	}
</style>
</head>
<body>
<header>
<h1>Welcome</h1>
</header>
<div class="content">
<div class= "register">
    <h3>Register!</h3>
    
    <p><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/register" modelAttribute="user">
    	<p>
    	<form:label path="name">Name:</form:label>
    	<form:input path="name"></form:input>
    	</p>

    	<p>
            <form:label path="email">Email:</form:label>
            <form:input type="email" path="email"/>
        </p>
    	<p>
        <p>
            <form:label path="password">Password:</form:label>
            <form:password path="password"/>
        </p>
        <p>
            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
            <form:password path="passwordConfirmation"/>
        </p>
        <input type="submit" value="Register!"/>
    </form:form>
    </div>
    <div class="login">
     <h3>Login</h3>
    <p><c:out value="${errors}" /></p>
    <form method="post" action="/login">
        <p>
            <label for="email">Email</label>
            <input type="text" id="email" name="email"/>
        </p>
        <p>
            <label for="password">Password</label>
            <input type="password" id="password" name="password"/>
        </p>
        <input type="submit" value="Login!"/>
    </form>
    </div>
    </div>
</body>
</html>