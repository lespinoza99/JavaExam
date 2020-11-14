<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Info</title>
</head>
<style>
	.buttons{
		display: flex;
	}
</style>
<body>
<a href="/tasks">Home</a>
	<h1>Task: <c:out value="${task.task }"></c:out></h1>
	<p>Creator: <c:out value="${task.creator.name }"></c:out></p>
	<p>Assignee: <c:out value="${task.assignee.name }"></c:out></p>
	<p>Priority: <c:out value="${task.priorty }"></c:out></p>
	
	<div class="buttons">
	<c:if test="${userId.equals(task.creator.id)}">
	<form action="/tasks/${task.id}/edit">
		<button type="submit">Edit</button>
	</form>
	</c:if>
	<c:if test="${userId.equals(task.creator.id)}">
	<form action="/tasks/${task.id }/delete">
		<button type="submit">Delete</button>
	</form>
	</c:if>
	<c:if test="${userId.equals(task.assignee.id)}">
	<form action="/tasks/${task.id }/delete">
		<button type="submit">Complete</button>
	</form>
	</c:if>
	</div>
</body>
</html>