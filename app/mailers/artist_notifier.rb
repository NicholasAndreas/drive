class ArtistNotifier < ApplicationMailer::Base
  default from: "contact@iwantink.co" #, bcc: 'andrunix@gmail.com'
  # default from: "postmaster@madrilla.com", bcc: 'andrunix@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.artist_notifier.signedup.subject
  #
  def signedup(artist)
    @artist = artist
        attachments.inline['iwantinklogo.png'] = File.read('app/assets/images/iwantinklogo.png')

    mail to: artist.email, bcc: 'admin@iwantink.co', subject: "Thanks for signing up with iwantink!"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.artist_notifier.confirmed.subject
  #
  def confirmed
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def contact(name, email, message)
    @name = name
    @email = email
    @message = message
    mail to: "andrunix@gmail.com", subject: "Comments from users"
  end


  def add_to_artist(artist)
    @arist = artist
    mail to: user.email, subject: "You've been added as a Tattooist on Iwantink"
  end



  # When a new appointment is created, this mailer is used
  def artist_new_bookings(booking)
    @booking = booking
    @artist = booking.artist
    mail to: [@artist.email, @artist.phone_for_sms],
      subject: "New Appointment with #{@client.name}"
  end

  # When a new appointment is created, this mailer is used
  def client_new_appointment(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @client = appointment.client
    @stylist = appointment.stylist
    mail to: @client.email, subject: "Appointment with #{@stylist.name} Requested"
  end

  # when an artist confirms a booking
  def appointment_confirmed(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client
    mail to: @client.email, subject: "Your Appointment Has Been Confirmed"
  end

  def client_confirmed(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client

    if @stylist.phone_for_sms.nil?
      mail to: @stylist.email,
        subject: "#{@client.name} Confirmed Your Updated Appointment"
    else
      mail to: @stylist.email,
        cc: @stylist.phone_for_sms,
        subject: "#{@client.name} Confirmed Your Updated Appointment"
    end
  end

  def appointment_canceled(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client

    bcc = [@client.phone_for_sms, @stylist.phone_for_sms].join(',')
    if @client.phone_for_sms.nil?
      mail to: @artist.email, subject: "Appointment Canceled"
    else
      mail to: @artist.email, cc: @stylist.email, bcc: bcc, subject: "Appointment Canceled"
    end
  end

  def password_reset(user)
    @artist = artist
    mail to: @artist.email, subject: "Password Reset Request"
  end

  def user_reschedule(appointment)
    @booking = booking
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client

    if @stylist.phone_for_sms.nil?
      mail to: @stylist.email,
        subject: "Appointment Rescheduled by #{@client.name}"
    else
      mail to: @stylist.email,
        cc: @stylist.phone_for_sms,
        subject: "Appointment Rescheduled by #{@client.name}"
    end
  end

  def artist_reschedule(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client


    if @client.phone_for_sms.nil?
      mail to: @client.email,
        subject: "Appointment Rescheduled by #{@artist.name}"
    else
      mail to: @artist.email,
        cc: @artist.phone_for_sms,
        subject: "Appointment Rescheduled by #{@artist.name}"
    end
  end

end
