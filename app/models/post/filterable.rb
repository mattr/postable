module Post::Filterable
  extend ActiveSupport::Concern
  
  included do
    scope :filter_by_title, ->(title) { where(arel_table[:title].matches("%#{sanitize_sql_like(title)}%")) }
  end
  
  class_methods do
    def filter_by(params)
      return self if params.blank?
      
      Filter.new(params).apply(self)
    end
    
    def filter_by!(params)
      self = filter_by(params)
      self
    end
  end
end