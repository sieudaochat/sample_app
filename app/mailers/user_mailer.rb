class UserMailer < ApplicationMailer

  def account_activation user
    @user = user
    mail to: user.email, subject: t("active.accountactivation")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("passreset.passreset")
  end
end
