antpool
=======

ANT-POOL API integration. Ruby gem.

Installation
------------

Add this line to your application's Gemfile:

```
gem 'ant-pool-api', :require => 'ant'
```

And then execute:

```
$ bundle
```

Usage
-----

##How to use?

###1. Create your ruby project

###2. Add "require 'ant'"

###3. Create class

```ruby
  api = Ant::API.new(username, api_key, api_secret)
```

```
username - your username on ant-pool
api_key - your API key
api_secret - your API secret code
```

#### Full API documentation: https://www.antpool.com/apiGuild.htm

###4. Examples

####Connect and get balance:

```ruby
 # -*- encoding : utf-8 -*-
require 'rubygems'
require 'ant'

api = Ant::API.new(username, api_key, api_secret)
puts api.account

```

```json
{"code":0, "message":"ok", "data":{"earn24Hours":"0.00000000", "earnTotal":"0.00000000", "paidOut":"0.00000000", "balance":"0.00000000"}}
```

####Get Hashrate:

```ruby
puts api.hashrate
```

```json
{"code":0, "message":"ok", "data":{"last5m":"0", "last15m":"0", "last1h":"0", "last1d":"0", "prev5m":"0", "prev15m":"0", "prev1h":"0", "prev1d":"0", "accepted":"0", "stale":"0", "dupelicate":"0", "other":"0"}}
```
