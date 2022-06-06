# load all gems from our gemfile
require 'dotenv/load'
require 'json'
require 'HTTParty'
require 'csv'

#set authentication variables for http basic auth
auth = {:username=> ENV['projectID'], :password => ENV['token']}
host = ENV['spaceURL']

#the campaign ID you would like to search
campaignID = ''

#the file will be written to a CSV file named based on your campaign ID
writePath = campaignID+".csv"

#empty array for our numbers
assignedNumbers = []

#the URL we will make our get request to
url = host+'/api/relay/rest/registry/beta/campaigns/'+campaignID+'/numbers'

#create a get request to our URL, using our authentication
response = HTTParty.get(url,:basic_auth=>auth)


#Parse the response as JSON, and add each phone number to our array
jsonResponse = JSON.parse(response.body)
jsonResponse['data'].each {|x| assignedNumbers.push(x['phone_number']['number'])}


# Check for next page and repeat the process until we have exhausted all pages
while jsonResponse['links']['next'] != nil
    response = HTTParty.get(host+jsonResponse['links']['next'],:basic_auth=>auth)
    jsonResponse = JSON.parse(response.body)
    jsonResponse['data'].each {|x| assignedNumbers.push(x['phone_number']['number'])}
end

#Print the total numbers in a campaign
puts "This campaign has: "+assignedNumbers.length.to_s+" phone numbers assigned"

#Write our assignedNumbers array to a CSV
CSV.open(writePath, 'w') do |csv|
    csv << assignedNumbers
end
