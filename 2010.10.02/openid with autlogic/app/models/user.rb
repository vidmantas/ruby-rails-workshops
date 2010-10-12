class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validate_login_field = false
    c.validate_email_field = false
    c.openid_required_fields = [ :email, "http://axchema.org/contact/email" ]
  end
end
