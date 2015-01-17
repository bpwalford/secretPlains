class DashboardsController < ApplicationController

  def index
  end

  def fingerprint
  end

  def record_fingerprint
    # binding.pry
    if current_user.fingerprints.count == 0
      FingerprintBuilder.new(current_user, params).build
    else
      fingerprint = FingerprintBuilder.new(current_user, params).build
      DifferenceBuilder.new(current_user, fingerprint).build
    end
    redirect_to dashboard_path
  end

end
