module PasswordResetsHelper

 def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end



end
