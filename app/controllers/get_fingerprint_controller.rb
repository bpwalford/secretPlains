class GetFingerprintController < ApplicationController

  def retrieve
    fingerprint = current_user.fingerprints.last
    render json: fingerprint
  end

  def compare
    # binding.pry
  end

end
