class ProductsMailer < ApplicationMailer
  default from: "info@testshop.localhost",
          template_path: 'mailers/products'

  def product_bought(product, email, photo_url)
    @product = product
    @photo_url = photo_url
    mail to: email,
         subject: "Product was bought"
  end

  def admin_notification(id,email)
    @id = id
    mail to: email,
         subject: "Someone just bougth product"
  end

  def buy_product_error(user_email, email)
    @user_email = user_email
    mail to: email,
         subject: "Buy product error"
  end
end
