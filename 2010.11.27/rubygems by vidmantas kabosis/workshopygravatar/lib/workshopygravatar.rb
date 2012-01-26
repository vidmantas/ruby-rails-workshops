require 'digest/md5'
    
module Workshopygravatar
  def gravatar_for(email)
    email_address = email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "http://www.gravatar.com/avatar/#{hash}"
    "<img src=\"#{image_src}\" alt=\"Gravatar\" />".html_safe
  end
end

ActionController::Base.helper(Workshopygravatar)
