# Find All Messages by Error Code

## Overview
This snippet will pull all messages with a specific Error Code using the Ruby SDK

## Required Packages
This snippet uses two gems [`SignalWire`](https://rubygems.org/gems/signalwire) and [`Dotenv`](https://github.com/bkeepers/dotenv).

Additionally this snippet requires `CSV` which is part of the ruby standard gems

## Running this snippet
1. Configure your SignalWire credentials in your .env file
2. (Optionally) configure date-constraints using the comments
3. Set the `errorCode` variable to the code you would like to search for
4. Run app.rb, the CSV will be saved in the root directory of the script
