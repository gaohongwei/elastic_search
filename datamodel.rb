
  
  include Tire::Model::Search
  include Tire::Model::Callbacks

The first  one adds various searching and indexing methods 
The second one adds callbacks so that when an article is created, updated or destroyed the index is automatically updated.
