class MypageController < ApplicationController
  # Allow access only to logged-in users
  before_action :authenticate_user!

  def show
    # Fetch the currently logged-in user
    @user = current_user
  end

  private

    # Permitted user parameters
    def user_params
      params.require(:user).permit(:name, :email, :admin_flg)
    end
end