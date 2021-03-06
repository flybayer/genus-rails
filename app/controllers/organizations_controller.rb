class OrganizationsController < ApplicationController
  before_action :require_login

  def show
    @org = find_organization
    redirect_to [@org, @org.groups.first]
  end

  private

  def find_organization
    if current_organization.id == params[:id].to_i
      current_organization
    else
      Organization.includes(:groups).find(params[:id])
    end
  end
end
