package com.pwr.teamfinder.repository;

import com.pwr.teamfinder.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface Users extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);
    Optional<User> findByResetPasswordCode(String resetPasswordCode);
}
