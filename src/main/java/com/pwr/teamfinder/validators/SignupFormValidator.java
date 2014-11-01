package com.pwr.teamfinder.validators;

import javax.annotation.Resource;
import javax.swing.text.html.Option;
import javax.validation.ParameterNameProvider;
import javax.validation.executable.ExecutableValidator;

import com.pwr.teamfinder.domain.User;
import com.pwr.teamfinder.dto.SignupForm;
import com.pwr.teamfinder.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import java.util.Optional;

@Component
public class SignupFormValidator extends LocalValidatorFactoryBean {


    private UserRepository userRepository;

    @Autowired
    public SignupFormValidator(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.isAssignableFrom(SignupForm.class);
    }

    @Override
    public void validate(Object obj, Errors errors, final Object... validationHints) {

        super.validate(obj, errors, validationHints);

        if (!errors.hasErrors()) {
            SignupForm signupForm = (SignupForm) obj;
            Optional<User> existing = userRepository.findByEmail(signupForm.getEmail());
            if (existing.isPresent())
                errors.rejectValue("email", "email.error.notUnique");
            if (!signupForm.getPassword().equals(signupForm.getRetypePassword()))
                errors.rejectValue("retypePassword","password.error.doNotMatch");
            if (!signupForm.getEmail().equals(signupForm.getRetypeEmail()))
                errors.rejectValue("retypeEmail","email.error.doNotMatch");
        }

    }

    @Override
    public ExecutableValidator forExecutables() {
        return null;
    }

    @Override
    public ParameterNameProvider getParameterNameProvider() {
        return null;
    }
}