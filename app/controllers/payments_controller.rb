class PaymentsController < ApplicationController

    def create
        @article = Article.find(params[:id])
        customer = Stripe::Customer.create({
            email: params[:stripeEmail],
            source: params[:stripeToken],
        })
        charge = Stripe::Charge.create({
            customer: customer.id,
            amount: @article.price,
            description: "number:#{@article.id} title:#{@article.name}",
            currency: "jpy",
        })

        # 売れた時の処理
        if @article.update(sold_flg: true)
            redirect_to article_path(params[:id]), notice: "購入しました"
        end
        rescue Stripe::CardError => e
            flash[:error] = e.message,
            redirecto_to article_path()
        end
    end
end