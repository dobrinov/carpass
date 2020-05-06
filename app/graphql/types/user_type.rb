module Types
  class UserType < Types::BaseObject
    field :email, String, null: false
    field :last_login_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
