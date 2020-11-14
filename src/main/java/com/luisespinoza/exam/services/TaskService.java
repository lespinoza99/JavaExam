package com.luisespinoza.exam.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luisespinoza.exam.models.Task;
import com.luisespinoza.exam.repositories.TaskRepository;

@Service
public class TaskService {
	@Autowired
	private TaskRepository taskRepository;
	
	public List<Task> allTasks(){
		return (List<Task>) taskRepository.findAll();
	}
	
	public Task createTask(Task T) {
		return taskRepository.save(T);
	}
	
	public Task findTask(Long id) {
		Optional<Task> task = taskRepository.findById(id);
		if(task.isPresent()) {
			return task.get();
		}else {
			return null;
		}
	}

	public Task updateTask(Task T) {
		return taskRepository.save(T);
	}
	public void deleteTask(Long id) {
		taskRepository.deleteById(id);
	}
}
