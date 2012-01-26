class UserSession < Authlogic::Session::Base
  auto_register
  logout_on_timeout true
end
