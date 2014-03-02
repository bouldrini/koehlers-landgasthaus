ENV["AWS_S3_BUCKET"] = 'koehlers-landgasthaus'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => nil,
    :aws_secret_access_key  => nil
  }
  config.fog_directory  = ENV["AWS_S3_BUCKET"]
end
