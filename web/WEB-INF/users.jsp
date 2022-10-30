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
                    <th></th>
                    <th></th>

                </tr>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.email}</td>
                        <td>${user.active}</td>
                        <td>${user.first_name}</td>
                        <td>${user.last_name}</td>
                        <td class="roleText"><c:forEach items="${roles}" var="role">
                                <c:if test="${role.id == user.role}">
                                    ${role.role}
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <form action="user" method="get">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="email" value="${user.email}">
                                <input type="submit" value="Edit">
                            </form>
                        </td>
                        <td>
                            <form action="user" method="post">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="email" value="${user.email}">
                                <input type="submit" value="Delete">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <br>
        <a href="user?action=addUser">Add User</a>
            <c:if test="${action ne null}">
            <p>${message}</p>
            <p id="ade">${messageADE}</p>
            </c:if>
        </div>
    <c:if test="${action ne null}">
        <div>
        <h2>
        <c:if test="${action eq 'addUser'}">Add User</c:if>
        <c:if test="${action ne 'addUser'}">Edit User ${email}</c:if>
        </h2>
        <form action="user" method="POST">
            <table class="add">
                <c:if test="${action eq 'addUser'}">
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
                        <td><input type="text" name="password" placeholder="Password" value="${password}"/></td>
                    </tr>
                </c:if>
                <c:if test="${action ne 'addUser'}">
                    <input type="hidden" name="email" value="${email}">
                    <tr>
                        <td>First Name: </td>
                        <td><input type="text" name="first_name" value="${first_name}"/></td>
                    </tr>
                    <tr>
                        <td>Last Name: </td>
                        <td><input type="text" name="last_name" value="${last_name}"/></td>
                    </tr>
                    <tr>
                        <td>Password: </td>
                        <td><input type="text" name="password" value="${password}"/></td>
                    </tr>
                </c:if>
                <tr>
                    <c:if test="${action ne 'addUser'}">
                    <td>Role: </td>
                    </c:if>
                    <td>
                        <select name="role" class="drop">
                            <c:forEach items="${roles}" var="roleN">
                                <option value="${roleN.id}" <c:if test="${roleN.id eq role}">selected</c:if>>${roleN.role}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                <c:if test="${action eq 'addUser'}">
                    <td><input type="submit" value="Add User" /></td>
                    <td><input type="hidden" name="action" value="add" /></td>
                </c:if>
                <c:if test="${action ne 'addUser'}">
                    <td><input type="hidden" name="action" value="update" /></td>
                    <td><input type="submit" value="Update" /></td>
                </tr>
                <tr>
                    <td><input type="hidden" name="action" value="cancel" /></td>
                    <td><input type="submit" value="Cancel"/></td>
                </tr>
                </c:if>
            </table>
        </form>
        <p>${message2}</p>
    </div>
    </c:if>
    </body>
</html>
