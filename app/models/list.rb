class List < ActiveRecord::Base
  has_many :items
  List.order(created_at: :desc)
end

