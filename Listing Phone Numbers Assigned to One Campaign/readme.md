# Listing Phone Numbers Assigned to One Campaign

## Overview
This snippet will pull all phone numbers from a SignalWire campaign regardless of assignment status.

## Required Packages
This snippet uses two gems [`HTTParty`](https://github.com/jnunemaker/httparty) and [`Dotenv`](https://github.com/bkeepers/dotenv).

Additionally this snippet requires `CSV` and `JSON` which are part of the ruby standard gems

## Running this snippet
1. Configure your SignalWire credentials in your .env file
2. assign the target campaign ID to the `campaignID` variable
3. run app.rb
