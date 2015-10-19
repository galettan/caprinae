class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :manager_user,     only: [:destroy, :edit, :update]

      def index
        @users = User.paginate(page: params[:page])
      end
      
      def show
        @user = User.find(params[:id])
      end
      
      def new
        @user = User.new
      end
      
      def edit
        @user = User.find(params[:id])
      end
      
      def create
        @user = User.new(user_params)
        
        if @user.save
          redirect_to @user
        else
          render 'new'
        end
      end
      
      def update
        @user = User.find(params[:id])
        @user_params = user_params


        if @user.update_attributes(@user_params)
          flash[:success] = 'Profil modifé avec succès'
          redirect_to @user
        else
          render 'edit'
        end
      end
      
      def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:success] = 'Utilisateur supprimé'
        
        redirect_to users_url
      end
      
      
    private
      def user_params
        params.require(:user).permit(:login, :password, :password_confirmation, :profile, :avatar)
      end
      
      def logged_in_user
        unless logged_in?
          flash[:danger] = 'Connectez-vous SVP'
          redirect_to login_url
        end
      end

      def correct_user
        @user = User.find(params[:id])
        unless (current_user?(@user) || current_user.manager?)
          flash[:danger] = 'Vous n\'avez pas les permissions nécessaires pour accéder à cette page'       
          redirect_to(user_url) 
        end
      end

      def manager_user
        current_user.manager?
      end
      
end
