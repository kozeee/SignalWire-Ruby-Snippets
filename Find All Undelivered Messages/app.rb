# load all gems from our gemfile
require 'dotenv/load'
require 'signalwire/sdk'
require 'csv'

# set authentication variables and establish our SignalWire Client
username = ENV['projectID']
password = ENV['token']
host = 'kody-guffey.signalwire.com'
@client = Signalwire::REST::Client.new username, password, signalwire_space_url: host

# request the message list from SignalWire
messages = @client.messages.list(
    #specify a to filter messages sent AFTER x date
        #date_sent_after:Date.new(2022,5,23)
    #specify a to filter messages sent BEFORE x date
        #date_sent_before:Date.new(2022,5,23)
    )

# our list for data
messageList = []
# headers for our csv
headers = ['sid','to','from','date']

# set status. Options: delivered, undelivered, sent, failed
status = 'delivered'

# for each message, if the message status is the status we are searching for, push the message data to our messageList
messages.each do|message|
    if message.status == status 
    messageList.push([message.sid,message.to,message.from,message.date_sent,]) 
    end
end

# write messageList to our CSV with headers
CSV.open('undelivered-MSG.csv','w',headers: headers, write_headers:true) do |csv|
    messageList.each do |message| 
        csv << message
    end
end
