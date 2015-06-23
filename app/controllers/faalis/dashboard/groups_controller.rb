class Faalis::Dashboard::GroupsController < ::ApplicationController
  layout false

  def new
    @permissions = {}
    @group = Faalis::Group.new

    Faalis::Permission.all.each do |perm|
      if @permissions.include? perm.model
        @permissions[perm.model] << [perm.permission_type, perm.id]
      else
        @permissions[perm.model] = [[perm.permission_type, perm.id]]
      end
    end
  end

  def create
    authorize Faalis::Group

    name = group_params[:name]
    @group = Faalis::Group.new(name: name, role: name.underscore)

    unless group_params[:permissions].nil?
      # TODO: Fix this for mongoid too.
      ids = group_params[:permissions].keys.map(&:to_i)
      @group.permissions = Faalis::Permission.where(id: ids)
    end

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

  def group_params
    params.require(:group).permit!
  end

end
