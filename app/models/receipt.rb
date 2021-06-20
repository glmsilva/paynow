class Receipt < ApplicationRecord
  before_create :set_slug
  belongs_to :charge


  private

  def set_slug 
    loop do
      self.slug = SecureRandom.uuid
      break unless Receipt.where(slug: slug).exists?
    end
  end
end
