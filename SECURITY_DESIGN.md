# Security Flow Design

# References

http://docs.spring.io/spring-security/site/docs/3.0.x/reference/technical-overview.html


# User Authentication

`Authentication`, to represent the principal in a Spring Security-specific manner.

A `GrantedAuthority` is, not surprisingly, an authority that is granted to the principal. Such authorities are usually “roles”, such as `ROLE_ADMINISTRATOR` or `ROLE_HR_SUPERVISOR` ( application-wide permissions granted to a principal.)

## Process
 
1. User logs in succesfully
1. The context information for that user is obtained (their list of roles and so on).
1. A security context is established for the user
1. The user proceeds, to perform some operation which is (potentially) protected by an access control mechanism. (Operation permissions vs. context)


# Components

## Security Context

`SecurityContextHolder` - the present security context of the application, which includes details of the principal currently using the application

Details of the principal currently interacting with the application. Won't t need to create an `Authentication` object, but is fairly common for users to query the Authentication object (i.e. Username)

### Important interfaces

`Authentication`, to represent the principal in a Spring Security-specific manner. (Get from `SecurityContext`)

`UserDetails`, to provide the necessary information to build an `Authentication` object from your application's DAOs or other source source of security data.

`UserDetailsService`, to create a `UserDetails` when passed in a String-based username (or certificate ID or the like).


## Access Decision Manager

`AccessDecisionManager` - It has a `decide( Authentication auth, Object resource, )`  method

```
<intercept-url pattern='/secure/**' access='ROLE_A,ROLE_B'/>
```

## Spring Security and LDAP 

https://spring.io/guides/gs/authenticating-ldap/


## Authentication Manager

# LDAP 

## Admin Guide

http://www.openldap.org/doc/admin22/quickstart.html

