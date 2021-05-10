class PaymentsController < ApplicationController

    def create
        @article = Article.find(params[:id])
        Stripe.setPublishableKey('pk_test_51IlXDcGqe1x0vObzU2m71lacmPCfsInoBu1K7F0kvHIVh7srrPkFRzA5ajwIAa8tvkSpl7orbvIqnsjHHGBIvX8c005402vood');
        
        binding.pry
        

        customer = Stripe::Customer.create({
            email: params[:stripeEmail],
            source: params[:stripeToken],
        })
        charge = Stripe::Charge.create({
            publishable_key: Rails.configuration.stripe[:publishable_key],
            customer: customer.id,
            amount: @article.price,
            description: "number:#{@article.id} title:#{@article.name}",
            currency: "jpy",
        })

        if @article.update(sold_flg: true)
            redirect_to article_path(params[:id]), notice: "購入しました"
        end
    end
end