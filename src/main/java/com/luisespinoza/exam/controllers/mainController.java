package com.luisespinoza.exam.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.luisespinoza.exam.models.Task;
import com.luisespinoza.exam.models.User;
import com.luisespinoza.exam.services.TaskService;
import com.luisespinoza.exam.services.UserService;
import com.luisespinoza.exam.validator.UserValidator;

@Controller
public class mainController {
	@Autowired
	private UserService userService;
	@Autowired
	private TaskService taskService;
	@Autowired
	private UserValidator userValidator;
	
	@RequestMapping("/")
	public String index(@ModelAttribute("user")User user) {
		return "RegAndLogin.jsp";
	}

	@PostMapping("/register")
	public String registerUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session,Model model) {
		userValidator.validate(user, result);
		if(result.hasErrors()) {
			return "RegAndLogin.jsp";
		}else {
			User u = userService.registerUser(user);
			session.setAttribute("userId", u.getId());
			return "redirect:/tasks";
		}
	}
	@RequestMapping("/login")
	public String login() {
		return "login.jsp";
	}
	
	@PostMapping("/login")
	public String loginUser(@RequestParam("email") String email,
							@RequestParam("password") String password,
							Model model, HttpSession session,RedirectAttributes redirectAttributes) {
		boolean isAuthenticated = userService.authenticateUser(email, password);
		if(isAuthenticated) {
			User u = userService.findByEmail(email);
			session.setAttribute("userId", u.getId());
			return "redirect:/tasks";
		}else {
			redirectAttributes.addFlashAttribute("errors", "Invalid Credentials, please try again");
			return "redirect:/";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/tasks")
	public String tasks(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if(userId == null) {
			return "redirect:/";		
		}else {
			User user = userService.findUserById(userId);
			model.addAttribute("user", user);
			List<Task> tasks = taskService.allTasks(); 
			model.addAttribute("tasks", tasks);
			return "tasks.jsp";
		}
		
	}
	
	@RequestMapping("/tasks/new")
	public String newTask(@ModelAttribute("taskName")Task task, Model model) {
		List<User> users = userService.allUsers();
		model.addAttribute("users", users);
		return "newTask.jsp";
	}
	
	@PostMapping("/tasks/new")
	public String createTask(@Valid @ModelAttribute("taskName") Task task, 
							BindingResult result, Model model, HttpSession session, 
							@RequestParam("assignee_id") Long assignee) {
		
		
		Long userId = (Long) session.getAttribute("userId");
		if(result.hasErrors()) {
			List<User> users = userService.allUsers();
			model.addAttribute("users", users);
			return "newTask.jsp";
		}else {
			taskService.createTask(task);
			Long taskId = task.getId();
			System.out.println(taskId);
			//Task t = taskService.findTask(taskId);
			User user = userService.findUserById(userId);
			//System.out.println(user.getName());
			User userAssigned = userService.findUserById(assignee); 
			task.setCreator(user);
			task.setAssignee(userAssigned);
			System.out.println(task.getAssignee().getName());
			System.out.println(assignee);
			//task.setAssignee(task.getAssignee());
			taskService.updateTask(task);
			userService.update(user);
		//	System.out.println(t.getCreator());
			return "redirect:/tasks";
		}
	}
	
	@RequestMapping("/tasks/{id}")
	public String taskInfo(@PathVariable("id") Long id, Model model, HttpSession session) {
		Task taskModel = taskService.findTask(id);
		model.addAttribute("task", taskModel);
		session.getAttribute("userId");
		model.addAttribute("userId", session.getAttribute("userId"));
		return "taskInfo.jsp";
	}
	
	@RequestMapping("/tasks/{id}/edit")
	public String editTask(@ModelAttribute("taskName") Task task, Model model, @PathVariable("id") Long id, HttpSession session) {
		Long userId = (Long)session.getAttribute("userId");
		Task taskModel = taskService.findTask(id);
		Long creatorId = taskModel.getCreator().getId();
		System.out.println(creatorId);
		if(!userId.equals(creatorId)) {
			return "redirect:/tasks";
		}else {
	
		model.addAttribute("task", taskModel);
		List<User> users = userService.allUsers();
		model.addAttribute("users", users);
		return "taskEdit.jsp";
	}
	}
	
	@PostMapping("/tasks/{id}/edit")
	public String submitEdit(@Valid @ModelAttribute("taskName") Task task, 
							BindingResult result, Model model, HttpSession session,
							@RequestParam("assignee_id") Long assignee,@PathVariable("id") Long id) {
		Long userId = (Long) session.getAttribute("userId");
		if(result.hasErrors()) {
			Task taskModel = taskService.findTask(id);
			model.addAttribute("task", taskModel);
			List<User> users = userService.allUsers();
			model.addAttribute("users", users);
			return "taskEdit.jsp";
		}else {
			taskService.updateTask(task);
			//Long taskId = task.getId();
			User user = userService.findUserById(userId);
			User userAssigned = userService.findUserById(assignee);
			task.setCreator(user);
			task.setAssignee(userAssigned);
			taskService.updateTask(task);
			userService.update(user);
			return "redirect:/tasks/";
		}
		
	}
	
	@RequestMapping("/tasks/{id}/delete")
	public String delete(@PathVariable("id")Long id) {
		taskService.deleteTask(id);
		return "redirect:/tasks";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
