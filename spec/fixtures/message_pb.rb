# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: spec/fixtures/message.proto

require 'google/protobuf'

require 'google/protobuf/timestamp_pb'
require 'google/protobuf/wrappers_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("spec/fixtures/message.proto", :syntax => :proto3) do
    add_message "example.User" do
      optional :id, :uint32, 1
      optional :name, :string, 2
      optional :avatar_url, :message, 3, "google.protobuf.StringValue"
      optional :registered_at, :message, 4, "google.protobuf.Timestamp"
      optional :birthday, :message, 5, "example.Date"
      optional :age, :uint32, 6
      repeated :skills, :string, 7
      optional :preference, :message, 11, "example.Preference"
      repeated :works, :message, 12, "example.Work"
      repeated :accounts, :message, 13, "example.Account"
    end
    add_message "example.Preference" do
      optional :email, :string, 1
    end
    add_message "example.Work" do
      optional :company, :string, 1
      optional :position, :string, 2
    end
    add_message "example.Date" do
      optional :year, :uint32, 1
      optional :month, :uint32, 2
      optional :day, :uint32, 3
    end
    add_message "example.Account" do
      oneof :account do
        optional :github, :message, 1, "example.GithubAccount"
        optional :twitter, :message, 2, "example.TwitterAccount"
      end
    end
    add_message "example.GithubAccount" do
      optional :login, :string, 1
    end
    add_message "example.TwitterAccount" do
      optional :login, :string, 1
    end
  end
end

module TestFixture
  User = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.User").msgclass
  Preference = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.Preference").msgclass
  Work = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.Work").msgclass
  Date = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.Date").msgclass
  Account = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.Account").msgclass
  GithubAccount = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.GithubAccount").msgclass
  TwitterAccount = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("example.TwitterAccount").msgclass
end
