require 'active_record'

RSpec.describe Pb::Serializer do
  class self::User < ActiveRecord::Base
   has_one :profile
   has_one :preference
  end
 
  class self::Profile < ActiveRecord::Base
    belongs_to :user
    has_many :works
  end

  class self::Work < ActiveRecord::Base
    belongs_to :proflie
  end

  class self::Preference < ActiveRecord::Base
    belongs_to :user
  end

  class self::UserSerializer < Pb::Serializer::Base
    message TestFixture::User

    delegates :name, :works, to: :profile

    depends on: { profile: :birthday }
    def age
      [Date.today, birthday].map { |d| d.strftime('%Y%m%d').to_i }.then { |(t, b)| t - b } / 10000
    end

    depends on: { profile: :birthday }
    def birthday
      object.birthday
    end

    depends on: { profile: :avatar_url }
    def avatar_url
      object.profile.avatar_url || 'http://example.com/default_avatar.png'
    end

    depends on: { profile: :avatar_url }
    def original_avatar_url
      object.profile.avatar_url
    end
  end

  class self::WorkSerializer < Pb::Serializer::Base
    message TestFixture::Work
  end

  class self::DateSerializer < Pb::Serializer::Base
    message TestFixture::Date
  end

  before do
    ActiveRecord::Base.establish_connection(
      adapter:  "sqlite3",
      database: ":memory:",
    )
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.create_table :users do |t|
      t.datetime :registered_at
    end
    m.create_table :preferences do |t|
      t.belongs_to :user_id
      t.string :email
    end
    m.create_table :profiles do |t|
      t.belongs_to :user_id
      t.string :name
      t.string :avatar_url
      t.date :birthday
    end
    m.create_table :works do |t|
      t.string :company
    end
  end

  after do
    m = ActiveRecord::Migration.new
    m.verbose = false
    m.drop_table :preferences
    m.drop_table :works
    m.drop_table :profiles
    m.drop_table :users
  end

  it "has a version number" do
    expect(Pb::Serializer::VERSION).not_to be nil
  end

  describe '#to_pb' do
    it 'serializes ruby object into protobuf message' do
      work = self.class::Work.new(company: 'Example Company, inc.')
      serializer = self.class::WorkSerializer.new(work)
      pb = serializer.to_pb
      expect(pb).to be_kind_of TestFixture::Work
      expect(pb.company).to eq work.company
    end
  end
end
