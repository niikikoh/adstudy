class Payment
    def self.register_customer(card_token)
        Stripe:Customer.create({
            source: card_token,
        })
    end

    def self.fetch_customer(customer_id)
        Stripe::Customer.retrieve(customer_id)
    end

    def self.delete_customer(customer_id)
        Stripe::Customer.delete(customer.id)
    end

    def self.register_card(customer_id:, card_token:)
        Stripe::Customer.create_source(
            customer_id,
            { source: card_token},
        )
    end

    def self.delete_card(customer_id:, card_id:)
        Stripe::Customer.delete_source(
            customer_id,
            card_id,
        )
    end

    def self.one_time_charge(price:, customer_id:)
        Stripe::Charge.create({
            amount: price,
            currency: 'jpy',
            customer: customer_id,
        })
    end
end