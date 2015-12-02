1.  Query
  __elasticsearch__.client.search(index: index_name, body: query)
  __elasticsearch__.search(queries)
  queries={query:'query', sort:'sort'}
  
  def es_search(queries, options = {})
    return [] unless queries
    queries[:sort] = options[:sort] if options[:sort]
    return __elasticsearch__.search(queries).per(MAX) if options[:all]
    __elasticsearch__.search(queries)
  end

  def es_search_with_pagination(queries, page_number, options = {})
    return es_search(queries, options) if options[:all]
    es_search(queries, options).page(page_number)
  end
  
2. Count
  es_query=__elasticsearch__.client.search(index: index_name, body: query, search_type: :count)
  es_query.try(:[], 'count') || 0
3. Count on group by 
  query=query.merge!(aggs: { results: { terms: { field: group_by_field, size: 0 } } })
  es_query=__elasticsearch__.client.search(index: index_name, body: query, search_type: :count)
  buckets=es_query
    .try(:[], 'aggregations')
    .try(:[], 'results')
    .try(:[], 'buckets') || []
  pairs=buckets.map do |result|
    [result['key'], result['doc_count']]
  end
  Hash[pairs] # key=>doc_count

  def es_count_by(queries, field)
    queries = queries.merge!(aggs: { results: { terms: { field: field, size: 0 } } })
    __elasticsearch__.client.search(index: index_name, body: queries, search_type: :count)
      .try(:[], 'aggregations')
      .try(:[], 'results')
      .try(:[], 'buckets') || []
  end
  def es_count(queries)
    return 0 unless queries
    __elasticsearch__.client.count(index: index_name, body: queries).try(:[], 'count') || 0
  end   
