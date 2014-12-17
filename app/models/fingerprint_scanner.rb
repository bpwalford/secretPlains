class FingerprintScanner

  attr_reader :fingerprint, :plugins, :fonts, :version, :cookies, :agent, :language, :user

  def initialize(fingerprint)
    @fingerprint  = "#{fingerprint[:plugins]}#{fingerprint[:fonts]}#{fingerprint[:agent]}#{fingerprint[:version]}#{fingerprint[:cookies]}#{fingerprint[:language]}"
    @plugins      = fingerprint[:plugins]
    @fonts        = fingerprint[:fonts]
    @version      = fingerprint[:version]
    @cookies      = fingerprint[:cookies]
    @agent        = fingerprint[:agent]
    @language     = fingerprint[:language]
    @user         = User.find_by(email: fingerprint[:email])
  end

  def scan
    return false if !user
    return false if user.fingerprints.first.print != fingerprint
    true
  end

end

# set value for each comparator
#   plugins

# class for each comparator?
#   character type count
#   space count
#   size count
#   installed fonts
#   uninstalled fonts
#


# user agent reader
#   recognizes different browsers


# create a module which contains all the passible values for each comparator
#   minimums
#     if below minimum automatic rejectance
#   relative value for enterence
#     e.g. plugin may have a total value of 30%, while cookies has %5
#   all comparator values can include the module so tolerances can be adjusted in one place
#
# each comparator will return a percentage (0-100) which is then translated into its global value
#   e.g. a cookies match will equate to 100% but be translated to the max value indicated by the comparators module


# when users are wrongfully rejected the email brings them to the dash borad but first fingerprints the computer,
# calculates the percent difference of in current finger print and last finger and adjust global attribute tolerence to
# reflect that difference

# what happens when a user isn't wrongfully rejected, but claims otherwise?
#   maybe email isn't necessary?
#     get emergency password on first login
#       recalculate fingerprint tolerances on correct password
#   need to protect against total tolerance degredation
#     have a constant of minimum values
#       eventually, these minimums will be met...
#   need a means of raising tolerence, just because on person's print changed drastically doesn't mean all tolerances
#   should be adjusted
#     maybe have a maxium tolerence minimization rate?
#     in extreme cases send an email which causes user fingerprints to be reset on next login
