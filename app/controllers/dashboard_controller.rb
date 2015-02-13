class DashboardController < ApplicationController

  def index
  end

  def fingerprint
  end

  def record_fingerprint
    if current_user.fingerprints.count == 0
      FingerprintBuilder.new(current_user, params).build
    else
      fingerprint = FingerprintBuilder.new(current_user, params).build
    end
    
    redirect_to dashboard_path
  end

  def compare
    @original = Fingerprint.find(params[:fingerprint_one][:fingerprint_id])

    @altered = Fingerprint.find(params[:fingerprint_two][:fingerprint_id])

    @difference = Difference.where(original: @original, altered: @altered).first

    @matched = matched_attributes(@original, @altered, @original.attributes.except(
      'id', 'created_at', 'updated_at', 'user_id'
    ).keys)

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
      format.js { render partial: "dashboard/comparisons_js/#{partial}" }
    end
  end

  private

  def matched_attributes(original, altered, attrs)
    attribute_matches = {matched: [], total: [], unique: []}

    attrs.each do |attr|
      attribute_matches[:total] << attr
      attribute_matches[:matched] << attr if original.send(attr) == altered.send(attr)
      attribute_matches[:unique] << attr if original.send(attr) != altered.send(attr)
    end

    attribute_matches
  end

end
