module Queryable
  extend ActiveSupport::Concern
  
  def initialize(query)
    @query = query
  end

  def build(params)
    params = params.dup.to_h
    collect(params).reduce(self) { |builder, collected| reflect(builder.send(*collected)) }
  end

  def call
    @query
  end
  
  private
  
  def collect(params)
    params.compact_blank.map { |key, value| ["by_#{key}", value] }
  end

  def reflect(query)
    self.class.new(query)
  end

  def table
    @query.arel_table
  end
end   