class ChargesController < ApplicationController
  def new

   # --agrregate all the peding seats ticket price
   # pending_seats = Seat.where('pendingpayment = true')
   # @amount = 0;
   # pending_seats.each do | seat | 
   #   @amount = @amount + seat.price

   @amount = 0;
   unique_seat = Seat.where('id = 201');
   unique_seat.each do | seat |
    @amount = @amount + seat.price;
     # puts @amount 
     #puts seat.price
     #puts seat.id
     #puts seat.pendingpayment
   end
  end
  
  def create
    # Amount in cents
    @amount = 10000
    # @amount = params[:stripeAmount].to_i * 100
    # @email = params[:stripeEmail]
    
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      # :card  => params[:stripeToken]
      :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    rescue Stripe::CardError => e
     flash[:error] = e.message
     redirect_to charges_path
     flash[:notice] = "please try again"       
  end
end
