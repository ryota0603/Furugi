class Admin::HomesController < ApplicationController
   # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!
  
  def top
  end
end
