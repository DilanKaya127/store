require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "triggers in_stock email when product comes back in stock" do
    product = products(:alice_mutton)
    product.update!(units_in_stock: 0) # Stoğu sıfırla
    subscriber = subscribers(:dilan)

    # Teslimat kutusunu temizle
    ActionMailer::Base.deliveries.clear

    # Stoğa sokalım
    product.update!(units_in_stock: 5)

    # Mail gerçekten gönderildi mi?
    assert_equal 1, ActionMailer::Base.deliveries.size

    mail = ActionMailer::Base.deliveries.last
    assert_equal "In stock", mail.subject
    assert_equal [ subscriber.email ], mail.to
    assert_match "Good news", mail.body.encoded
  end
end
