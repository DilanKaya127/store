# require "test_helper"

# class ProductMailerTest < ActionMailer::TestCase
#   test "in_stock" do
#     mail = ProductMailer.in_stock
#     assert_equal "In stock", mail.subject
#     assert_equal [ "to@example.org" ], mail.to
#     assert_equal [ "from@example.com" ], mail.from
#     assert_match "Hi", mail.body.encoded
#   end
# end

require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "in_stock" do
    mail = ProductMailer.with(product: products(:"Alice Mutton"), subscriber: subscribers(:dilan)).in_stock
    assert_equal "In stock", mail.subject
    assert_equal [ "dilankaya177@gmail.com" ], mail.to
    assert_equal [ "dilankaya127@gmail.com" ], mail.from
    assert_match "Good news!", mail.body.encoded
  end
end
