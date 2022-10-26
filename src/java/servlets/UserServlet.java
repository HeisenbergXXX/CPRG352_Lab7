/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Role;
import models.User;
import services.RoleService;
import services.UserService;

/**
 * @author Bennett
 */
@WebServlet(name = "UserServlet", urlPatterns = {"/user"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserService us = new UserService();
        RoleService rs = new RoleService();
        try {
            List<User> users = us.getAll();
            List<Role> roles = rs.getAll();
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("messageGet", ex.getMessage());
        }


        request.getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserService us = new UserService();
        RoleService rs = new RoleService();

        //input validation
        String email = request.getParameter("email");
        boolean active = false;
        String firstname = request.getParameter("first_name");
        String lastname = request.getParameter("last_name");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("role"));

        if (email == null || email.isEmpty() ||
                firstname == null || firstname.isEmpty() ||
                lastname == null || lastname.isEmpty() ||
                password == null || password.isEmpty())
        {
            request.setAttribute("message2", "Please fill out all fields");
            try {
                List<User> users = us.getAll();
                List<Role> roles = rs.getAll();
                request.setAttribute("users", users);
                request.setAttribute("roles", roles);
            } catch (Exception ex) {
                Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("message", "error");
            }
            request.setAttribute("first_name", firstname);
            request.setAttribute("last_name", lastname);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
            request.getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);
            return;
        }

        User user = new User(email, active, firstname, lastname, password, roleId);

        String action = request.getParameter("action");
        //add, delete edit user
        try {
            switch (action) {
                case "add":
                    us.insert(user);
                    break;
                case "edit":
                    us.update(user);
                    break;
                case "delete":
                    us.delete(email);
                    break;
            }
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("messageADE", ex.getMessage());
            request.setAttribute("first_name", firstname);
            request.setAttribute("last_name", lastname);
            request.setAttribute("email", email);
            request.setAttribute("password", password);
        }

        try {
            List<User> users = us.getAll();
            List<Role> roles = rs.getAll();
            request.setAttribute("users", users);
            request.setAttribute("roles", roles);
        } catch (Exception ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            request.setAttribute("message", "error");
        }
        request.setAttribute("messageADE", "Deleted");
        request.getRequestDispatcher("/WEB-INF/users.jsp").forward(request, response);


    }

}

