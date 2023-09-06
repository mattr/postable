class Post::Filterable::Filter
  include ::Filterable
  
  attribute :published, :boolean
  attribute :search, :string
  attribute :tags, array: true, default: []
  attribute :title
  
  def apply(scope)
    Query.new(scope).build(filters).call
  end
  
  private
  
  class Query
    include Queryable
    
    private
    
    def by_search(value)
      @query.index_search(value)
    end
    
    def by_title(value)
      # @query.filter_by_title(value)
      # or
      @query.where(table[:title].matches("%#{@query.sanitize_sql_like(value)}%"))
    end
    
    def by_tags(values)
      @query.where(tags: values)
    end
    
    def by_published(value)
      @query.published if value
    end
  end
end