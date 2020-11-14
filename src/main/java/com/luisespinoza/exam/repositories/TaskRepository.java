package com.luisespinoza.exam.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.luisespinoza.exam.models.Task;

@Repository
public interface TaskRepository extends CrudRepository<Task,Long>{
	

}
