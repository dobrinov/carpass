module Types
  class QueryType < Types::BaseObject
    field :me, UserType, null: false

    def me
      context[:current_user]
    end
  end
end
