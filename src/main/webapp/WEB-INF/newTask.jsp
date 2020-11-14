<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix = "form" uri = "http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Task</title>
</head>
<body>
	<div>
		<h1>Create a new Task</h1>
		
		<p><form:errors path="task.*"/></p>
		<form:form method="POST" action="/tasks/new" modelAttribute="taskName">
		
		<p>
			<form:label path="task">Task</form:label>
			<form:input path="task"></form:input>
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

			<input type="submit" value="Create"/>
		</form:form>
	</div>

</body>
</html>