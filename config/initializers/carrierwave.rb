
puts ENV["AWS_ACCESS_KEY_ID"].inspect
puts ENV["AWS_SECRET_ACCESS_KEY"].inspect
puts ENV["AWS_S3_BUCKET"].inspect

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV["AWS_ACCESS_KEY_ID"],
    :aws_secret_access_key  => ENV["AWS_SECRET_ACCESS_KEY"],
    # :region                 => 'us-west-2',
    :endpoint               => 'https://s3.amazonaws.com'
  }
  config.fog_directory  = ENV["AWS_S3_BUCKET"]
end
