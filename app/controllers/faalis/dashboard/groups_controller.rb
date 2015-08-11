class Faalis::Dashboard::GroupsController < ::ApplicationController
  layout false

  before_action :get_all_permissions, only: [:new, :edit]

  def new
    authorize Faalis::Group
    @group = Faalis::Group.new
  end


  def edit
    @group = Faalis::Group.find(params[:id])
    authorize @group
  end

  def create
    authorize Faalis::Group

    name = group_params[:name]
    @group = Faalis::Group.new(name: name, role: name.underscore)

    @group.permissions = populate_permissions

    respond_to do |f|
      if @group.save
        f.js
        f.html
      else
        f.js { render :errors }
        f.html
      end
    end

  end

  def update
    @group = Faalis::Group.find(params[:id])
    authorize @group

    @group.permissions = populate_permissions
    @group.name        = group_params[:name]
    @group.role        = group_params[:name].underscore

    respond_to do |f|
      if @group.save
        f.js
        f.html
      else
        f.js { render :errors }
        f.html
      end
    end
  end

  private

  def populate_permissions
    unless group_params[:permissions].nil?
      # TODO: Fix this for mongoid too.
      ids = group_params[:permissions].keys.map(&:to_i)
      Faalis::Permission.where(id: ids)
    end
  end

  def group_params
    params.require(:group).permit!
  end

  def get_all_permissions
    @permissions = {}
    Faalis::Permission.all.each do |perm|
      if @permissions.include? perm.model
        @permissions[perm.model] << [perm.permission_type, perm.id]
      else
        @permissions[perm.model] = [[perm.permission_type, perm.id]]
      end
    end
  end
end
