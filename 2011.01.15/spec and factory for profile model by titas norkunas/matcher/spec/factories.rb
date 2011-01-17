Factory.sequence :name do |n|
  "Profile #{n}"
end

Factory.define :profile do |p|
  p.name Factory.next(:name)
  p.number 1
end

Factory.define :male_profile, :parent => :profile do |p|
  p.sex Profile::MALE
end

Factory.define :female_profile, :parent => :profile do |p|
  p.sex Profile::FEMALE
end

