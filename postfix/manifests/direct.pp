class postfix::direct inherits postfix {
   File["/etc/postfix/main.cf"] { content => template("postfix/main.cf-direct.erb") }
}
