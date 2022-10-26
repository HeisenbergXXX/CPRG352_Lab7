<%-- 
    Document   : users
    Created on : 23-Oct-2022, 11:25:24 AM
    Author     : Bennett
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<style><%@include file="/WEB-INF/Lab7Style.css"%></style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User JSP Page</title>
    </head>
    <body>
        <div>
            <h2>Manage Users</h2>
            <table>
                <tr>
                    <th>Email</th>
                    <th>Status</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Edit</th>
                    <th>Delete</th>

                </tr>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.active}</td>
                        <td>${user.first_name}</td>
                        <td>${user.last_name}</td>
                        <td>${user.role}</td>
                        <td><a href="editUser.jsp?email=${user.email}">Edit</a></td>
                        <td><a href="user?action=delete&amp;email=${user.email}">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
            <p>${message}</p>
            <p>${messageADE}</p>
        </div>
    <div>
        <h2>Add User</h2>
        <form action="user" method="POST">
            <table class="add">
                <tr>
                    <td><input type="text" name="email" placeholder="Email" value="${email}"/></td>
                </tr>
                <tr>
                    <td><input type="text" name="first_name" placeholder="First Name" value="${first_name}"/></td>
                </tr>
                <tr>
                    <td><input type="text" name="last_name" placeholder="Last Name" value="${last_name}"/></td>
                </tr>
                <tr>
                    <td><input type="password" name="password" placeholder="Password" value="${password}"/></td>
                </tr>
                <tr>
                    <td>
                        <select name="role" placeholder="Role" class="drop">
                            <c:forEach items="${roles}" var="role">
                                <option value="${role.id}">${role.role}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="submit" value="Add User" /></td>
                    <td><input type="hidden" name="action" value="add" /></td>
                </tr>
            </table>
        </form>
        <p>${message2}</p>
    </div>
    </body>
</html>
