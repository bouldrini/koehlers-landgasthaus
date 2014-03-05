ENV["AWS_S3_BUCKET"] = 'koehlers-landgasthaus'

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAI2MNIUEW5CVOKPKA',

    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = ENV["AWS_S3_BUCKET"]
end
