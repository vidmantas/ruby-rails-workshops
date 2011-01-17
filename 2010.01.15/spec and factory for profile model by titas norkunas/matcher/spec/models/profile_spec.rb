require 'spec_helper'

describe Profile do

  describe "instance" do
    before { @profile = Factory :profile }

    subject { @profile }

    it { should respond_to :name       }
    it { should respond_to :number     }
    it { should respond_to :sex        }
    it { should respond_to :profile_id }
  end

  describe "validations" do
    it { should validate_presence_of(:name) } # shoulda sugar
    it { should validate_numericality_of(:number) } # shoulda sugar

    context "should validate" do
      before { @profile = Factory.build :profile }

      it "less than 1000001" do
        @profile.number = 1000001
        @profile.save
        @profile.errors.values.flatten.should include("must be less than or equal to 1000000")
      end

      it "greater than 0" do
        @profile.number =  0
        @profile.save
        @profile.errors.values.flatten.should include("must be greater than or equal to 1")
      end
    end
  end

  describe "relations" do
    it { should have_one :profile } # shoulda sugar
  end

  describe "callbacks" do
    before do
      @profile = Factory :profile
    end

    it "should call match before saving if does not have date" do
      @profile.should_receive(:has_date?).and_return(false)
      @profile.should_receive(:match)
      @profile.save
    end

    it "should not call match before saving if has date" do
      @profile.should_receive(:has_date?).and_return(true)
      @profile.should_not_receive(:match)
      @profile.save
    end
  end

  describe "methods" do
    describe "match" do
      before do
        @male   = Factory :male_profile
        @female = Factory.build :female_profile
      end

      it "should find a match if there is any" do
        #pending "please fix: does not find match" do
        @female.number = @male.number
        @female.save
        @female.profile.should == @male
        @male.reload
        @male.profile.should == @female
        #end
      end

      it "should not find a match if there is none" do
        @female.number = @male.number + 1
        @female.save
        @female.profile.should == nil
      end
    end
  end
end

