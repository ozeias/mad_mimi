require File.expand_path('../request', __FILE__)

module MadMimi #:nodoc
  # The Mailer API that lets you use Mad Mimi to send your transactional emails like welcome letters,
  # password resets, and account activations. You can also use it to programmatically send promotional
  # emails to an audience list.

  class Mailer
    include Request

    # Sending transactional email
    #
    # Sends a single transactional email to the recipient. Returns a unique transaction id if successful.
    #
    # == Required parameters are:
    # * <tt>:promotion_name</tt> -- The name of the promotion Mimi will send. For +raw_html+ or +raw_plain_text+ promotions, Mad Mimi will automatically create or update the promotion in your account.
    # * <tt>:recipients</tt> -- The recipient (singular although the parameter name is plural) again just the email or in +Display Name <email@domain.com>+ format.
    # * <tt>:body</tt> -- Required if you have placeholders. YAML encoded replacements for any {placeholders} in your promotion.
    #
    # == Optional parameters are:
    # * <tt>:subject</tt> -- The subject of the email. Will default to the +promotion_name+ if not supplied.
    # * <tt>:from</tt> -- The from address. Just the email address or in +Display Name <email@domain.com>+ format.
    # * <tt>:bcc</tt> -- An email address to BCC. Just the email address.
    # * <tt>:raw_html</tt> -- The custom HTML to send. Can be used on its own or in conjunction with +raw_plain_text+.
    # * <tt>:raw_plain_text</tt> -- The custom plain text to send. Can be used on its own or in conjunction with +raw_html+.
    # * <tt>:check_suppressed</tt> -- Checks if the recipient is suppressed and does not send if so (default: on).
    # * <tt>:track_links</tt> -- Enable or disable link tracking in HTML promotions (default: on).
    # * <tt>:hidden</tt> -- Creates the promotion as a hidden promotion so as not to clutter up your web interface (default: off).
    #
    # See {Sending transactional email with the Mailer API}[http://madmimi.com/developer/mailer/transactional]
    def mail(options = {})
      options[:check_suppressed] ||= true
      post("/mailer", options, true, true)
    end
  end
end