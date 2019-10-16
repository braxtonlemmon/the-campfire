require 'aws-sdk-s3'

Aws.config.update(
	credentials: Aws::Credentials.new(ENV['AWS_ID'], ENV['AWS_SECRET'])
)
Aws.config.update({region: 'eu-west-3'})
