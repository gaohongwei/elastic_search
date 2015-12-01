1.  Query
  __elasticsearch__.client.search(index: index_name, body: query)

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
  Hash[pairs]
