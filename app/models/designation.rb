class Designation < ActiveRecord::Base
  has_many :users
  scope :designation_list, -> {pluck(:designation_name, :id)}
end
