class UsersController < ApplicationController

  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authorize_user, only: [:update, :destroy ]
  before_action :require_user_signed!, only: [:edit, :update, :destroy ]

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
        UserMailer.with(user: @user).welcome_email.deliver_later

        # Redirect to main view if the user is an admin
        if current_user != nil && current_user.admin?
          redirect_to users_path, notice: "#{@user.email} successfully created."
        # Redirect to user profile if not admin
        else
          session[:current_user_id] = @user.id
          redirect_to @user, notice: "Account successfully created!"
        end

      # If the user's not saved re-render the correct form with user errors
      else
        # Errors must be saved and displayed through the session instead of through form errors because rendering
        # templates breaks Bootstrap styling
        session[:errors] = @user.errors.full_messages

        redirect_to "users/new?=admin"
      end

    # end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      # Update user and redirect to profile
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "Account successfully updated!" }
        format.json { render :show, status: :ok, location: @user }
      # Re-render for with ajax errors
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    respond_to do |format|
      if session[:current_user_id] == @user.id || current_user.admin?
        @user.destroy!
        UserMailer.with(user: @user).delete_email.deliver_later
        if current_user != nil && current_user.admin?
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

end