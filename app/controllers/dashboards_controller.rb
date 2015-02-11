class DashboardsController < ApplicationController

  def index
  end

  def fingerprint
  end

  def record_fingerprint
    if current_user.fingerprints.count == 0
      FingerprintBuilder.new(current_user, params).build
    else
      fingerprint = FingerprintBuilder.new(current_user, params).build
      # DifferenceBuilder.new(current_user, fingerprint).build
    end
    redirect_to dashboard_path
  end

  def compare
    @original = Fingerprint.find(params[:fingerprint_one][:fingerprint_id])

    @altered = Fingerprint.find(params[:fingerprint_two][:fingerprint_id])

    @difference = Difference.where(original: @original, altered: @altered).first

    @difference = DifferenceBuilder.new(
      DifferenceCalculator.new(@original, @altered, Levenshtein.new)
    ).build if @difference == nil

    @comparable_attributes = @original.attributes.except(
      'created_at',
      'updated_at',
      'id',
      'user_id'
    )
  end

  def add_comparison_partial
    @original = Fingerprint.find(params[:original])
    @altered  = Fingerprint.find(params[:altered])
    @difference = Difference.find(params[:difference])

    partial = params[:attribute]
    respond_to do |format|
      format.js { render partial: "dashboards/comparisons_js/#{partial}" }
    end
  end

end
