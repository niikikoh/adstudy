class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @articles = current_user.articles.all.order('updated_at DESC')
    @profile = current_user.profile
    @user = @profile.user
  end

  def new
    @profile = current_user.build_profile
  end

  def create
    @profile = current_user.build_profile(profile_params)

    @profile.assign_attributes(profile_params) #.assign_attributesは変更するだけで保存はしない。フォームから送られてきた値（profile_params）を保存できなかった場合、記入していた文字がそのまま残ってrenderされる
    if @profile.save
      flash[:success] = "プロフィールの登録に成功しました"
      redirect_to root_url
     else
      flash[:danger] = "プロフィールの登録に失敗しました"
      render :edit
    end

  end

  def edit
    @profile = current_user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile

    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, flash: {success: 'プロフィールを更新しました'}
    else
      flash.now[:error] = '更新できませんでした'
      render :edit
    end

  end

  private

    def profile_params
      params.require(:profile).permit(:name,
                                      :bio,
                                      :avatar,
                                      :user_id, 
                                      :article_id)
    end

end
