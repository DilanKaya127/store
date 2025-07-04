module Product::Notifications
    extend ActiveSupport::Concern

    included do
        has_many :subscribers, dependent: :destroy
        after_update_commit :notify_subscribers, if: :back_in_stock?
    end

    def back_in_stock?
        units_in_stock_previously_was == 0 && units_in_stock > 0
    end

    def notify_subscribers
        subscribers.each do |subscriber|
            ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
        end
    end
end
