<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
    <%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Task</title>
</head>
<body>
<a href="/tasks">Home</a>
	<h1>Task: <c:out value="${task.task }"></c:out></h1>
	<p><form:errors path="task.*"/></p>
		<form:form method="post" action="/tasks/${task.id}/edit" modelAttribute="taskName">
		<input type="hidden" name="_method" value="PUT" />
		
		<p>
			<form:label path="task">Task</form:label>
			<form:errors path="task"></form:errors>
			<form:input path="task" placeholder="${task.task }"></form:input>
		</p>
		<p>
			<form:label path="priorty">Priority:</form:label>
			<form:select path="priorty">
    				<form:option value="High">High</form:option>
    				<form:option value="Medium">Medium</form:option>
    				<form:option value="Low">Low</form:option>
    	</form:select>
		</p>
		<p>
			<label for="assignee">Assignee</label>
			<select name="assignee_id" >
    			<c:forEach items="${users}" var="user">
    				<option value="${user.id}"><c:out value="${user.name}"></c:out></option>
    			</c:forEach>
    		</select>
		
		</p>

			<input type="submit" value="Edit"/>
		</form:form>
</body>
</html>