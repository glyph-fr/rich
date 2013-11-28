module Rich
  module FilesHelper

    def thumb_for_file(file)
      if file.simplified_type == "image"
        file.rich_file.url(:rich_thumb)
      else
        asset_path "rich/document-thumb.png"
      end
    end

    # Wrapper around S3DirectUpload uploader helper to ensure the lib is
    # configured before calling it
    #
    def s3_upload_form(*args, &block)
      configure_s3_direct_upload!
      s3_uploader_form *args, &block
    end

    private

    # Hook to configure S3DirectUpload with user data specified in Rich
    # initializer
    #
    def configure_s3_direct_upload!
      S3DirectUpload.config do |config|
        Rich.s3_direct_upload_config.each do |key, value|
          config.public_send(:"#{ key }=", value)
        end
      end
    end
  end
end
