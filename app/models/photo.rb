class Photo < ActiveRecord::Base
  belongs_to :listing

  has_attached_file :image,
                    styles: { :medium => "600x600>" },
                    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
