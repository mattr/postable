class Post < ApplicationRecord
  include Filterable
  
  scope :published, -> { where.not(published_at: nil).where(published_at: ..Time.zone.now) }
end
