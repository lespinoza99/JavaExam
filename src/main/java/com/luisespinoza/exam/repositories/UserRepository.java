package com.luisespinoza.exam.repositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.luisespinoza.exam.models.User;



@Repository
public interface UserRepository extends CrudRepository<User,Long>{
	User findByEmail(String email);

}