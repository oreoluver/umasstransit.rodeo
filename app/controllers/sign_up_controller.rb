class SignUpController < Devise::SessionsController

  def create_user
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    user = User.new user_params
    if user.save
      redirect_to root_path, notice: 'User was created'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
                                 :admin, :judge,
                                 :circle_check_scorer,
                                 :master_of_ceremonies,
                                 :quiz_scorer
  end
end