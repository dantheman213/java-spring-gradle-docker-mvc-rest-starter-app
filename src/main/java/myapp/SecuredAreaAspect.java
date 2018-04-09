package myapp;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.nio.file.AccessDeniedException;

@Aspect
@Component
public class SecuredAreaAspect {
    // This Aspect class is used to give reference to @SecureArea annotation.
    // All routes that need authorization can be processed here.

    @Pointcut("@annotation(myapp.SecuredArea)")
    private void securedAreaAnnotation() {

    }

    @Around("myapp.SecuredAreaAspect.securedAreaAnnotation()")
    public Object doSomething(ProceedingJoinPoint pjp) throws Throwable {
        HttpServletRequest req = getRequest();

        // Check header values or whatever custom code you want to do to secure this URL route and method
        Logger.info("Authorization was checked!");

        // Throw Spring's AccessDeniedException if needed
        // throw new AccessDeniedException("Invalid credentials");

        return pjp.proceed();
    }

    private HttpServletRequest getRequest() {
        ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return sra.getRequest();
    }
}
