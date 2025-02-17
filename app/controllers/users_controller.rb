class UsersController < ApplicationController

  # Assign the user to an accessible instance variable
  before_action :set_user, only: %i[ show edit update destroy ]
  # An extra layer of security ensuring users can only change their own information
  before_action :authorize_user, only: [:update, :destroy ]
  # Allow only users that are signed in to access edit, update, and delete requests
  before_action :require_user_signed!, only: [:edit, :update, :destroy ]
  # Force validation of cloudflare turnstile on user creation
  before_action :validate_cloudflare_turnstile, only: [:create] if Rails.env.production?
  rescue_from RailsCloudflareTurnstile::Forbidden, with: :failed_turnstile

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    # Readd respond_to and format.html/json responses to reinitialize Turbo
    # respond_to do |format|

      if @user.save
        if ENV["RAILS_ENV"] == "production"
          UserMailer.with(user: @user).welcome_email.deliver_now
        end
        # Redirect to main view if the user is an admin
        if current_user != nil && current_user.admin?
          redirect_to users_path, notice: "#{@user.email} successfully created."
        # Redirect to user profile if not admin
        else
          session[:current_user_id] = @user.id
          redirect_to @user, notice: "Account successfully created!"
        end

      # If the user's not saved re-render the forms with session errors
      else
        # Errors must be saved and displayed through the session instead of through form errors because rendering
        # templates breaks Bootstrap styling
        session[:errors] = @user.errors.full_messages

        # Redirect back to the previous requested form or home page if that fails
        redirect_back fallback_location: root_path

      end
    # end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update

    if user_signed_in? then @user.signed_in = true end

    # Respond_to still working even with Turbo Drive off. Remove respond_to and format responses if it fails
    respond_to do |format|
      # Update user and redirect to profile
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Account successfully updated!" }
        format.json { render :show, status: :ok, location: @user }
      # Re-render form with ajax errors
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    # Reference :update comment
    respond_to do |format|
      if session[:current_user_id] == @user.id || current_user.admin?
        @user.destroy!
        UserMailer.with(user: @user).delete_email.deliver_now
        if current_user != nil && current_user.admin? && @user != current_user
          format.html { redirect_to users_path, notice: "User #{@user.email} deleted." }
          format.json { head :no_content }
        else
          session.delete(:current_user_id)
          format.html { redirect_to root_path, notice: "Goodbye!" }
          format.json { head :no_content }
        end
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation,
        :profile_photo,
        :first_name,
        :last_name,
        :hours,
        :linkedin,
        :bio,
        :ngo,
        :admin)
    end

    # Authorize the current user or any admin in session to update or delete only themselves.
    def authorize_user
      unless @user == current_user || current_user.admin?
        render json: { error: 'Not Authorized' }, status: :unauthorized
      end
    end

    def failed_turnstile
      flash[:alert] = "We had trouble creating your account. Please try again."
      redirect_to root_path
    end
end
