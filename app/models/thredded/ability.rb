module Thredded
  class Ability
    include ::CanCan::Ability

    def initialize(user)
      user ||= Thredded::NullUser.new
      user_details = user.thredded_user_detail

      can :manage, :all if user.thredded_admin?

      can :read, Thredded::Messageboard do |messageboard|
        Thredded::MessageboardUserPermissions.new(messageboard, user).readable?
      end

      can :admin, Thredded::Topic do |topic|
        Thredded::TopicUserPermissions.new(topic, user, user_details).adminable?
      end

      can :edit, Thredded::Topic do |topic|
        Thredded::TopicUserPermissions.new(topic, user, user_details).editable?
      end

      can :update, Thredded::Topic do |topic|
        Thredded::TopicUserPermissions.new(topic, user, user_details).editable?
      end

      can :read, Thredded::Topic do |topic|
        Thredded::TopicUserPermissions.new(topic, user, user_details).readable?
      end

      can :create, Thredded::Topic do |topic|
        Thredded::TopicUserPermissions.new(topic, user, user_details).creatable?
      end

      can :manage, Thredded::PrivateTopic do |private_topic|
        Thredded::PrivateTopicUserPermissions.new(private_topic, user, user_details).manageable?
      end

      can :create, Thredded::PrivateTopic do |private_topic|
        Thredded::PrivateTopicUserPermissions.new(private_topic, user, user_details).creatable?
      end

      can :read, Thredded::PrivateTopic do |private_topic|
        Thredded::PrivateTopicUserPermissions.new(private_topic, user, user_details).readable?
      end

      can :edit, Thredded::Post do |post|
        Thredded::PostUserPermissions.new(post, user, user_details).editable?
      end

      can :manage, Thredded::Post do |post|
        Thredded::PostUserPermissions.new(post, user, user_details).manageable?
      end

      can :create, Thredded::Post do |post|
        Thredded::PostUserPermissions.new(post, user, user_details).creatable?
      end
    end
  end
end
