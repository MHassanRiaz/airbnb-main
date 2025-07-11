class Payment < ApplicationRecord
  belongs_to :reservation

  monetize :per_night_cents, allow_nil: false
  monetize :base_fare_cents, allow_nil: false
  monetize :service_fee_cents, allow_nil: false
  monetize :total_amount_cents, allow_nil: false
end
