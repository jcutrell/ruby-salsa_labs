
require "spec_helper"

describe SalsaLabs::Donation do

  let(:donation) do
    {
    }
  end

  let(:donation) { SalsaLabs::Donation.new(attributes) }

  describe 'initialization' do
    let(:attributes) { {} }
    xit 'should accept symbol keys'

    it 'should be a donation' do
      expect(SalsaLabs::Donation.object_name).to eq('donation')
      expect(donation.object_name).to eq('donation')
    end
  end

  describe "#attributes" do
    it "returns the attributes hash passed in to initialize" do
      expect(donation.attributes).to eq(attributes)
    end
  end

  describe "#donation_key" do
    it "returns the suppoter_key attribute as an integer" do
      expect(donation.donation_key).to eq(31337)
    end
  end

  describe "#organization_key" do
    it "returns the organization_key attribute as an integer" do
      expect(donation.organization_key).to eq(1234)
    end
  end

  describe "#chapter_key" do
    it "returns the chapter_key attribute as an integer" do
      expect(donation.chapter_key).to eq(90210)
    end
  end

  describe "#title" do
    it "returns the title as an attribute" do
      expect(donation.title).to eq('Mr.')
    end
  end

  describe "#first_name" do
    it "returns the first name as an attribute" do
      expect(donation.first_name).to eq('John')
    end
  end

  describe "#first_name=" do
    it "sets the first name as an attribute" do
      donation.first_name = 'Nathan'
      expect(donation.first_name).to eq('Nathan')
    end
  end

  describe "#mi" do
    it "returns the middle initial as an attribute" do
      expect(donation.mi).to eq('Jacob')
    end
  end

  describe "#last_name" do
    it "returns the last_name as an attribute" do
      expect(donation.last_name).to eq('Jingleheimer Schmidt')
    end
  end

  describe "#suffix" do
    it "returns the suffix as an attribute" do
      expect(donation.suffix).to eq('IV')
    end
  end

  describe "#email" do
    it "returns the email as an attribute" do
      expect(donation.email).to eq('johnjacob@example.com')
    end
  end

  describe "#receive_email" do
    it "returns the receive email as a boolean" do
      expect(donation.receive_email).to eq(true)
    end
  end

  describe "#phone" do
    it "returns the phone as an attribute" do
      expect(donation.phone).to eq('1234567890')
    end
  end

  describe "#street" do
    it "returns the street as an attribute" do
      expect(donation.street).to eq('123 Main St')
    end
  end

  describe "#street_2" do
    it "returns the street_2 as an attribute" do
      expect(donation.street_2).to eq('Apt 404')
    end
  end

  describe "#city" do
    it "returns the city as an attribute" do
      expect(donation.city).to eq('Schnechtady')
    end
  end

  describe "#state" do
    it "returns the state as an attribute" do
      expect(donation.state).to eq('NY')
    end
  end

  describe "#zip" do
    it "returns the zip as an attribute" do
      expect(donation.zip).to eq('12345')
    end
  end

  describe "#country" do
    it "returns the country as an attribute" do
      expect(donation.country).to eq('USA')
    end
  end

  describe "#source" do
    it "returns the source as an attribute" do
      expect(donation.source).to eq('rspec')
    end
  end

  describe "#status" do
    it "returns the status as an attribute" do
      expect(donation.status).to eq('Active')
    end
  end

  describe "#tracking_code" do
    it "returns the status as an attribute" do
      expect(donation.tracking_code).to eq('abc123')
    end
  end

  describe '#tracking_info_blank?' do
    context 'source details and tracking code filled in' do
      it 'should be false' do
        expect(donation.tracking_info_blank?).to be_falsey
      end
    end

    context 'source_details nil, source_tracking_code filled in' do
      before(:each) do
        donation.source_details = nil
      end

      it 'should be false' do
        expect(donation.tracking_info_blank?).to be_falsey
      end
    end

    context 'source_details nil, source_tracking_code nil' do
      before(:each) do
        donation.source_details = nil
        donation.source_tracking_code = nil
      end

      it 'should be true' do
        expect(donation.tracking_info_blank?).to be_truthy
      end
    end

    context 'source_details default, source_tracking_code default' do
      before(:each) do
        donation.source_details = 'No Referring info'
        donation.source_tracking_code = 'No Original Source'
      end

      it 'should be true' do
        expect(donation.tracking_info_blank?).to be_truthy
      end
    end
  end

  describe ".fetch" do
    let(:donations_fetcher) { double('DonationsFetcher', fetch: []) }

    before(:each) do
      SalsaLabs::DonationsFetcher.stub(new: donations_fetcher)
    end

    it "calls .fetch on an SalsaLabs::DonationsFetcher object" do
      SalsaLabs::Donation.fetch

      expect(donations_fetcher).to have_received(:fetch)
    end
  end

  describe 'save' do

    let(:object_saver) { double('SalsaObjectsSaver', save: []) }

    before(:each) do
      SalsaLabs::SalsaObjectsSaver.stub(new: object_saver)
    end

    it "calls .fetch on an SalsaLabs::DonationsFetcher object" do
      donation.save

      expect(object_saver).to have_received(:save)
    end
  end
end
