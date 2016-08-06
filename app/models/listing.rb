class Listing < ActiveRecord::Base
#  has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "default.jpg",
#                    :storage => :dropbox,
#                    :dropbox_credentials => Rails.root.join("config/s3.yml")
#
#  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

   has_attached_file :image, styles: { medium: "200x", thumb: "100x100>" }, default_url: "default.jpg",
                     :storage => :s3,
                     :s3_region => ENV['AWS_REGION'],
                     :s3_host_name => 'etsydemo.s3-website-us-east-1.amazonaws.com',
                     :s3_credentials => Proc.new{|a| a.instance.s3_credentials }
                     validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png)

  def s3_credentials
    #{:bucket => "etsydemo", :access_key_id => "AKIAIOPEJJKQXJXFPRSQ", :secret_access_key => "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"}
    {:bucket => "etsydemo", :access_key_id => "AKIAIOPEJJKQXJXFPRSQ", :secret_access_key => ENV["SECRET_ACCESS_KEY"]}
  end
end
