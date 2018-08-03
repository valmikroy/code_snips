#!/usr/bin/env ruby
require 'aws-sdk-s3'  

region = 'us-west-2'
s3 = Aws::S3::Resource.new(region: region)

bucket = s3.bucket('bucket_name')

# url expires in one day
bucket.objects.each do |obj|
  puts "#{obj.key} => #{obj.object.presigned_url(:get, expires_in: 1 * 24 * 60 * 60)}"
end
