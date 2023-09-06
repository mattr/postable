module Filterable
  extend ActiveSupport::Concern
  
  included do
    include ActiveModel::Model
    include ActiveModel::Attributes
  end
  
  def filters
    @filters ||= attributes.dup.each_value { |value| value.try(:compact_blank!) }.compact_blank
  end
end