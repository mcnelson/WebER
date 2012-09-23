def try_login(email, password)
  email = email[/\A\w+/].downcase  # Throw out the domain, if it was there
  email << "@mycompany.com"        # I only check people in my company

  ldap = Net::LDAP.new(
    host: 'ldap.mycompany.com',    # Thankfully this is a standard name
    auth: { method: :simple, email: email, password: password }
  )
  if ldap.bind
    # Yay, the login credentials were valid!
    # Get the user's full name and return it
    ldap.search(
      base:         "OU=Users,OU=Accounts,DC=mycompany,DC=com",
      filter:       Net::LDAP::Filter.eq( "mail", email ),
      attributes:   %w[ displayName ],
      return_result:true
    ).first.displayName.first
  end
end
