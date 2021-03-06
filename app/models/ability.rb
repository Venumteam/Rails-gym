class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Authorized user
    if user.persisted?
      can :index, User
      can [:show, :update, :destroy], User, id: user.id
      can [:create, :update, :destroy], Like,  user_id: user.id
      can [:create, :update, :destroy], Comment,  user_id: user.id
      can [:create, :update, :destroy], Post,  user_id: user.id
      can [:create, :update, :destroy], Food,  user_id: user.id
      can [:create, :update, :destroy], Product,  user_id: user.id
      can [:index, :create, :update, :destroy, :diary_stats], TrainingDiary,  user_id: user.id
      can [:create, :update, :destroy], Product,  user_id: user.id
      can [:create], UserTrainingPlan,  user_id: user.id
    end

    can [:index, :show], Workout
    can [:create], OrderedUser
    can [:index, :show], Comment
    can [:index, :show], Like
    can [:index, :show, :recommended_posts], Post
    can [:index, :show, :recommended_foods], Food
    can [:index, :show], Gallery
    can [:index, :show, :recommended_products], Product
    can [:index, :show, :create, :update], Order
    can [:index, :show, :create, :update], OrderItem
    can [:index, :show], Exercise
    can [:index], ListOfExercise
    can [:index], UsersTraining
    can [:index], Category
  end
end
