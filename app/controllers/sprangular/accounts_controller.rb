class Sprangular::AccountsController < Sprangular::BaseController
  before_filter :check_authorization, except: :create

  def create
    @user = Spree::User.create(spree_user_params)
    @order = current_order

    if @user.persisted?
      sign_in(:spree_user, @user)
      @order.update(user: @user) if @order && !@order.user

      render 'show'
    else
      invalid_resource!(@user)
    end
  end

  def show
    authorize! :show, @user
    @order = current_order
    render json: @user,
           serializer: Sprangular::UserSerializer
  end


  def update
    authorize! :update, @user
    @user.update_attributes spree_user_params

    if @user.valid?
      @order = current_order

      render 'show'
    else
      invalid_resource!(@user)
    end
  end

private

  def spree_user_params
    params.require(:spree_user).permit(Spree::PermittedAttributes.user_attributes)
  end
end
