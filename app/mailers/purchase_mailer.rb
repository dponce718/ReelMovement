class PurchaseMailer < ApplicationMailer
  layout 'purchase_mailer'
  default from: 'Reel Movement <reelmovementllc@gmail.com>'

  def purchase_receipt purchase
    @purchase = purchase
    mail to: purchase.email, subjet: "Thanks for joining Reel Movement"
   end 

 
 
end