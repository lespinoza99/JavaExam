<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Task Manager</title>
<style>
	header{
		display: flex;
		justify-content: space-between;
	}
</style>
</head>
<body>
	<header>
		<h1>Welcome, <c:out value="${user.name}"/> </h1>
		<a href="/logout">Logout</a>
	</header>
	<div class="table">
		<table>
		<thead>
			<tr>
				<th>Task</th>
				<th>Creator</th>
				<th>Assignee</th>
				<th>Priority</th>
			</tr>
		</thead>
		
		<tbody>
			<c:forEach items="${tasks}" var="task">
				<tr>
					<td><a href="/tasks/${task.id}">${task.task}</a><c:out value=""/></td>
					<td><c:out value="${task.creator.name}"/></td>
					<td><c:out value="${task.assignee.name}"/></td>
					<td><c:out value="${task.priorty}"/></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<input type="button" value="Create Task" onclick="location.href='/tasks/new'"/>
</body>
</html>