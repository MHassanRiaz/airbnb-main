class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update]

  def update

  @profile = current_user.profile || current_user.build_profile

  if @profile.update(profile_params)
    redirect_to edit_profile_path, notice: 'Profile updated successfully'
  else
    flash[:alert] = 'Failed to update profile'
    render :edit
  end
end

  def edit
  @profile = current_user.profile || current_user.build_profile
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(
      :picture,
      :name,
      :address_1,
      :address_2,
      :city,
      :state,
      :country_code
    )
  end
end
