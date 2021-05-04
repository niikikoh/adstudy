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
            currency: "jpy"
        })

        # 売れた時の処理
        if @article.update(sold_flg: true)
            redirect_to article_path(params[:id]), notice: "購入しました"
        end
        rescue Stripe::CardError => e
            flash[:error] = e.message,
            redirecto_to article_path(@article)
        end
    end

    # stripe関連でエラーが起こった場合
    rescue Stripe::CardError => e
        flash[:error] = "#決済(stripe)でエラーが発生しました。{e.message}"
        render :new

    # Invalid parameters were supplied to Stripe's API
    rescue Stripe::InvalidRequestError => e
        flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
        render :new

    # Authentication with Stripe's API failed(maybe you changed API keys recently)
    rescue Stripe::AuthenticationError => e
        flash.now[:error] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
        render :new

    # Network communication with Stripe failed
    rescue Stripe::APIConnectionError => e
        flash.now[:error] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
        render :new

    # Display a very generic error to the user, and maybe send yourself an email
    rescue Stripe::StripeError => e
        flash.now[:error] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
        render :new

    # stripe関連以外でエラーが起こった場合
    rescue => e
        flash.now[:error] = "エラーが発生しました#{e.message}"
        render :new
        end
end
