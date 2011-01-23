require File.expand_path('../request', __FILE__)
module MadMimi #:nodoc
  class Audience #:nodoc
    include Request

    # Get Audience Members
    #
    # Returns audience members paged in XML format.
    #
    # == Optional parameters are:
    # * <tt>:page</tt> -- the current page to fetch
    # * <tt>:per_page</tt> -- the number of audience members returned per page. Must be between 1 and 100
    # * <tt>:order</tt> -- the ordering. Must be one of email, first_name, last_name and created_at
    #
    # See {Get Audience Members}[http://madmimi.com/developer/lists]
    def members(options = {})
      members = get('/audience_members')
      members ? members["audience"]["member"] : members
    end

    # Get all Audience Lists
    #
    # Returns all audience lists
    #
    # See {Get all Audience Lists}[http://madmimi.com/developer/lists/get-all-audience-lists]
    def lists
      lists = get('/audience_lists/lists.xml')
      lists ? lists["lists"]["list"] : lists
    end

    # Add Audience List Membership
    #
    # This will add an existing member to a list or create a new audience member with that
    # email address and add that member to the list. Any additional parameters passed (such as
    # first_name and last_name) will be +added+ or +updated+ on the audience member.
    #
    # See {Add Audience List Membership}[http://madmimi.com/developer/lists/add-membership]
    def add_to_list(list, options = {})
      post("/audience_lists/#{list}/add", options, true)
    end

    # Remove Audience List Membership
    #
    # Removes an existing email address from an audience list. The member is not deleted
    # and will remain on any other lists. The email address is simply removed from that
    # audience list.
    #
    # See {Remove Audience List Membership}[http://madmimi.com/developer/lists/remove-membership]
    def remove_from_list(list, email)
      post("/audience_lists/#{list}/remove", {:email => email})
    end

    # Suppress an Audience Member
    #
    # This adds the audience member to your suppression list, effectively preventing sending
    # newsletters to that member (unsubscribing them). Audience members on your suppression
    # list do not count towards your total active audience.
    #
    # See {Suppress an Audience Member}[http://madmimi.com/developer/lists/suppress-email]
    def suppress(email)
      post("/audience_members/#{email}/suppress_email")
    end
  end
end