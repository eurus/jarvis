#!/usr/bin/env ruby
require 'qiniu'
Qiniu.establish_connection! access_key: 'your qiniu ak',
                            secret_key: 'your qiniu sk'
