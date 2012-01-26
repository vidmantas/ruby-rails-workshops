class Profile < ActiveRecord::Base
  MALE   = true
  FEMALE = false

  has_one :profile

  validates :name, :presence => true
  validates :number, :numericality => {:greater_than_or_equal_to => 1, :less_than_or_equal_to => 1000000}

  before_save :match, :unless => :has_date?

  def match
    self.profile = Profile.where("profile_id IS NULL AND number = ? AND sex != ?", number, sex).order("RANDOM()").first
    if self.profile
      self.profile.profile = self
    end
  end

  def has_date?
    self.profile.present?
  end
end

