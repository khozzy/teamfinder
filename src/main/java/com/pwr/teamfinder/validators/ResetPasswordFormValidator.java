package com.pwr.teamfinder.validators;

import com.pwr.teamfinder.domain.User;
import com.pwr.teamfinder.dto.ForgotPasswordForm;
import com.pwr.teamfinder.dto.ResetPasswordForm;
import com.pwr.teamfinder.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;

import javax.validation.ParameterNameProvider;
import javax.validation.executable.ExecutableValidator;
import java.util.Optional;

@Component
public class ResetPasswordFormValidator extends LocalValidatorFactoryBean {

    @Override
    public boolean supports(Class<?> clazz) {
        return clazz.isAssignableFrom(ResetPasswordForm.class);
    }

    @Override
    public void validate(Object obj, Errors errors, final Object... validationHints) {

        super.validate(obj, errors, validationHints);

        if (!errors.hasErrors()) {
            ResetPasswordForm resetPasswordForm = (ResetPasswordForm) obj;
            if (!resetPasswordForm.getPassword().equals(resetPasswordForm.getRetypePassword()))
                errors.reject("password.error.doNotMatch");
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