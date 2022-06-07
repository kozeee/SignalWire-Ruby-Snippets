# load all gems from our gemfile
require 'dotenv/load'
require 'signalwire/sdk'
require 'csv'

# set authentication variables and establish our SignalWire Client
username = ENV['projectID']
password = ENV['token']
host = ''
@client = Signalwire::REST::Client.new username, password, signalwire_space_url: host

# request the message list from SignalWire
messages = @client.messages.list(
    #specify to filter messages sent AFTER x date
        #date_sent_after:Date.new(2022,5,23)
    #specify to filter messages sent BEFORE x date
        #date_sent_before:Date.new(2022,5,23)
    #specify to filter messages sent BY a specific TFN in e.164 format
        #to:+12223334444
    )

# our list for data
messageList = []
# headers for our csv
headers = ['sid','to','from','date']

# set error code (INT only). Options: https://developer.signalwire.com/compatibility-api/reference/error-codes
errorCode = 30007

# for each message, if the error code matches the code we are searching for, push the message data to our messageList
messages.each do|message|
    if message.error_code == errorCode
    messageList.push([message.sid,message.to,message.from,message.date_sent,]) 
    end
end

# write messageList to our CSV with headers
CSV.open('Msg_ECC_'+errorCode.to_s+'.csv','w',headers: headers, write_headers:true) do |csv|
    messageList.each do |message| 
        csv << message
    end
end
