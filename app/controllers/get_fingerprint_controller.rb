class GetFingerprintController < ApplicationController

  def retrieve
    fingerprint = current_user.fingerprints.last
    render json: fingerprint
  end

end
