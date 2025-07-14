Rails.configuration.stripe_secret_key = ENV['STRIPE_SECRET_KEY'] || 'sk_test_...your_key_here'
Rails.configuration.stripe_publishable_key = ENV['STRIPE_PUBLISHABLE_KEY'] || 'pk_test_...your_key_here'

Stripe.api_key = Rails.configuration.stripe_secret_key
