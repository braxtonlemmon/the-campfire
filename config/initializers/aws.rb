require 'aws-sdk-s3'

Aws.config.update({
	region: 'eu-west-3',
	credentials: Aws::Credentials.new(ENV['AWS_ID'], ENV['AWS_SECRET']),
})

S3_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_BUCKET'])
