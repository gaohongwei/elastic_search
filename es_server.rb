#config/initializer/tire.rb
Tire.configure do
  url "http://localhost:9200"
  #you can uncomment the next line if you want to see the elasticsearch queries in their own seperate log
  #logger "#{Rails.root}/log/es.log" 
end


Tire.configure { url "http://myremoteserver.com:9200" }

# Can I sepcify multiple url?
Tire.configuration { url 'http://es1.example.com', 'http://es1.example.com' } 
