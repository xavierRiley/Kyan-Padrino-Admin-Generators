# Add Image helpers for use with magickly

IMAGE_HELPER = <<-IMAGE_HELPER
#{fetch_app_name()}.helpers do
  
  #Here be helpers for generating thumbs with magickly

    def magickly_img(src)
      @m_url = "/magickly?src=\#{src}"
      self
    end

    def resize_to_fit(height, width)
      @m_url << "&resize=\#{height}x\#{width}"
      self
    end

    def resize_to_fill(height, width)
      @m_url << "&thumb=\#{height}x\#{width}%23"
      self
    end

    def greyscale
      @m_url << "&greyscale=true"
      self
    end

    def src
      @m_url
    end

end
IMAGE_HELPER

create_file "app/helpers/image_helper.rb", IMAGE_HELPER
